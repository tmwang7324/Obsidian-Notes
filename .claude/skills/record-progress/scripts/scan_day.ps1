<#
.SYNOPSIS
  Deterministic core for the record-progress skill. Given a vault root and a date,
  resolves every path and gathers every candidate the daily Progress/ synthesis needs,
  emitting one JSON blob so the model never has to redo date math or mtime scanning.

.WHAT IT RETURNS (JSON to stdout)
  date, weekday, monday, week_folder        — week-folder math (Monday-based)
  journal_path, journal_exists              — the dated narrative source
  projects[]                                — one entry per project under Projects/
    .name
    .modified_notes[]  {path, folder, modified, filename_marker, body_markers, has_decision}
                       working/Ideas/Chats notes touched on the date. has_decision is true
                       when the note carries a **Decision** marker, a Decision header, or a
                       (DECISION) tag (the user's own convention) in its filename or body —
                       the signal to log a dated decision line and link UP to its wiki ADR
                       (synthesize authors the ADR; record-progress only links to it).
    .goals[]           goal file paths (to match Advances:)
    .iteration_logs[]  existing next-step file paths (to link instead of recreate)
    .existing_progress path of an already-written progress file for this date, or null
    .slug              tag slug derived from project name

  A project appears in projects[] only when it has >=1 modified note on the date
  (i.e. real activity) OR already has a progress file for the date. The journal is
  reported separately because it is shared across projects.

.NOTES
  Excludes the Progress/ folder itself, any Archive/ folder (already fully-processed notes),
  plus CLAUDE.md / COMMANDS.md, from "modified notes" — those are scaffolding or archived,
  not the day's substance. Modified date uses LastWriteTime.Date.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)] [string] $VaultRoot,
  [string] $Date = (Get-Date).ToString('yyyy-MM-dd')
)

$ErrorActionPreference = 'Stop'
$inv = [Globalization.CultureInfo]::InvariantCulture

$d = [datetime]::ParseExact($Date, 'yyyy-MM-dd', $inv)
$dow = [int]$d.DayOfWeek                 # Sunday=0 .. Saturday=6
$mondayOffset = ($dow + 6) % 7           # Monday=0
$monday = $d.AddDays(-$mondayOffset)

$monthFolder = '{0:00} {1}' -f $d.Month, $d.ToString('MMMM', $inv)
$journalRel  = "01 Journals/$($d.Year) Journals/$monthFolder/$($d.ToString('yyyy-MM-dd')).md"
$journalAbs  = Join-Path $VaultRoot $journalRel
$weekFolder  = "Week of $($monday.ToString('yyyy-MM-dd'))"

function To-Rel([string]$abs) {
  $full = (Resolve-Path -LiteralPath $abs).Path
  $root = (Resolve-Path -LiteralPath $VaultRoot).Path.TrimEnd('\')
  return $full.Substring($root.Length + 1).Replace('\', '/')
}

function Slugify([string]$name) {
  return ($name.ToLower() -replace '[^a-z0-9]+', '-').Trim('-')
}

$projectsRoot = Join-Path $VaultRoot 'Projects'
$projects = @()

if (Test-Path -LiteralPath $projectsRoot) {
  foreach ($proj in (Get-ChildItem -LiteralPath $projectsRoot -Directory)) {
    $modified = @()
    $mdFiles = Get-ChildItem -LiteralPath $proj.FullName -Recurse -File -Filter *.md -ErrorAction SilentlyContinue
    foreach ($f in $mdFiles) {
      if ($f.FullName -match '[\\/]Progress[\\/]') { continue }
      if ($f.FullName -match '[\\/]Archive[\\/]')  { continue }
      if ($f.Name -in @('CLAUDE.md', 'COMMANDS.md')) { continue }
      if ($f.LastWriteTime.Date -eq $d.Date) {
        $rel = To-Rel $f.FullName
        $segments = $rel.Split('/')
        $folder = if ($segments.Length -ge 3) { $segments[2] } else { '(root)' }

        # (DONE)/(INCOMPLETE) markers are the user's convention for "ship this to Done"
        # vs "this is still backlog". Detect them in the filename and anywhere in the body
        # so the synthesis can route each item correctly without guessing.
        $nameMarker = $null
        if ($f.Name -match '\((DONE|INCOMPLETE)\)') { $nameMarker = $Matches[1] }
        $bodyMarkers = @()
        $hasDecision = $false
        # A (DECISION) tag in the filename is also a decision signal (user's convention).
        if ($f.Name -match '\(DECISION\)') { $hasDecision = $true }
        $content = Get-Content -LiteralPath $f.FullName -Raw -ErrorAction SilentlyContinue
        if ($content) {
          if ($content -match '\(DONE\)')       { $bodyMarkers += 'DONE' }
          if ($content -match '\(INCOMPLETE\)') { $bodyMarkers += 'INCOMPLETE' }
          # Decision signals → log a dated decision line + link UP to the wiki ADR.
          # synthesize authors the ADR; we only link to it. Three equivalent triggers:
          #   1. a **Decision** line-prefix marker, 2. a header named "Decision", or
          #   3. a (DECISION) tag — the user's own convention (header suffix or inline),
          #      parallel to the (DONE)/(INCOMPLETE) markers detected above.
          if ($content -match '(?im)^\s*(\*\*Decision\*\*|#{1,6}\s*Decision\b)') { $hasDecision = $true }
          if ($content -match '\(DECISION\)')                                    { $hasDecision = $true }
          if ($hasDecision) {
            # skip done/incomplete markers in the body when detecting decisions, since a note might be "DONE" but still carry a decision signal that needs to be logged and linked up.
            $bodyMarkers = $bodyMarkers | Where-Object { $_ -notin @('DONE', 'INCOMPLETE') }
          }
        }

        $modified += [pscustomobject]@{
          path             = $rel
          folder           = $folder
          modified         = $f.LastWriteTime.ToString('s')
          filename_marker  = $nameMarker
          body_markers     = @($bodyMarkers)
          has_decision     = $hasDecision
        }
      }
    }

    $goals = @()
    $goalsDir = Join-Path $proj.FullName 'Goals'
    if (Test-Path -LiteralPath $goalsDir) {
      $goals = @(Get-ChildItem -LiteralPath $goalsDir -File -Filter *.md | ForEach-Object { To-Rel $_.FullName })
    }

    $iterLogs = @()
    $iterDir = Join-Path $proj.FullName 'Iteration Logs'
    if (Test-Path -LiteralPath $iterDir) {
      $iterLogs = @(Get-ChildItem -LiteralPath $iterDir -File -Filter *.md | ForEach-Object { To-Rel $_.FullName })
    }

    # Detect an existing progress file for this date in ANY "Week of *" folder, not just the
    # computed one — week folders in the wild are sometimes mislabeled, and we must never
    # create a duplicate for a date that's already logged.
    $existing = $null
    $progDir = Join-Path $proj.FullName 'Progress'
    if (Test-Path -LiteralPath $progDir) {
      $match = Get-ChildItem -LiteralPath $progDir -Recurse -File -Filter "*$($d.ToString('yyyy-MM-dd')).md" -ErrorAction SilentlyContinue | Select-Object -First 1
      if ($match) { $existing = To-Rel $match.FullName }
    }

    if ($modified.Count -gt 0 -or $existing) {
      $projects += [pscustomobject]@{
        name               = $proj.Name
        slug               = Slugify $proj.Name
        modified_notes     = @($modified)
        goals              = @($goals)
        iteration_logs     = @($iterLogs)
        existing_progress  = $existing
      }
    }
  }
}

$result = [pscustomobject]@{
  date           = $d.ToString('yyyy-MM-dd')
  weekday        = $d.DayOfWeek.ToString()
  monday         = $monday.ToString('yyyy-MM-dd')
  week_folder    = $weekFolder
  journal_path   = $journalRel
  journal_exists = (Test-Path -LiteralPath $journalAbs)
  projects       = @($projects)
}

$result | ConvertTo-Json -Depth 6
