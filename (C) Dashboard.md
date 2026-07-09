---
cssclasses:
  - dashboard
---
---

```dataviewjs
// ===== Time + Date (live clock) =====
if (window._dashClockId) clearInterval(window._dashClockId);   // guard against duplicate intervals on re-render
const box = dv.container.createDiv({ cls: "dash-clock" });
box.style.textAlign = "center";
box.style.padding = "0.4em 0 0.2em";
const t = box.createDiv({ cls: "dash-time" });
t.style.fontSize = "3.2em";
t.style.fontWeight = "700";
t.style.lineHeight = "1.05";
t.style.fontVariantNumeric = "tabular-nums";
const d = box.createDiv({ cls: "dash-date" });
d.style.fontSize = "1.1em";
d.style.opacity = "0.65";
const pad = n => String(n).padStart(2, "0");
function tick() {
  const now = new Date();
  t.textContent = `${pad(now.getHours())}:${pad(now.getMinutes())}:${pad(now.getSeconds())}`;
  d.textContent = now.toLocaleDateString("en-US", { weekday: "long", year: "numeric", month: "long", day: "numeric" });
}
tick();
window._dashClockId = setInterval(tick, 1000);
```


---

> [!multi-column]
>
>> [!blank|wide-1]
>> **📋 Today's Plan**
>>
>> ```dataviewjs
>> // ===== Today's Plan — embed Plans/Week of <Mon>/(C) <date>.md, else nudge. Never creates. =====
>> const now = new Date();
>> const pad = n => String(n).padStart(2, "0");
>> const ymd = dt => `${dt.getFullYear()}-${pad(dt.getMonth() + 1)}-${pad(dt.getDate())}`;
>> const dow = (now.getDay() + 6) % 7;               // 0 = Monday
>> const monday = new Date(now);
>> monday.setDate(now.getDate() - dow);
>> const path = `Plans/Week of ${ymd(monday)}/(C) ${ymd(now)}.md`;
>> if (app.vault.getAbstractFileByPath(path)) {
>>   let p = dv.paragraph(`![[${path}]]`);
>>   p.onclick = () => {
>> 	  app.workspace.openLinkText(path, "", false);
>>   };
>> } else {
>>   dv.paragraph(`*No plan yet for **${ymd(now)}** — run \`/daily-plan\` to generate today's checklist.*`);
>> }
>> ```
>
>> [!blank|wide-2]
>> **📓 Today's Journal**
>>
>> ```dataviewjs
>> // ===== Today's Journal — embed if it exists, else a button to create it =====
>> const MONTHS = ["01 January", "02 February", "03 March", "04 April", "05 May", "06 June",
>>                 "07 July", "08 August", "09 September", "10 October", "11 November", "12 December"];
>> const now = new Date();
>> const pad = n => String(n).padStart(2, "0");
>> const ymd = dt => `${dt.getFullYear()}-${pad(dt.getMonth() + 1)}-${pad(dt.getDate())}`;
>> const today = ymd(now);
>> const dow = (now.getDay() + 6) % 7;               // 0 = Monday
>> const monday = new Date(now);
>> monday.setDate(now.getDate() - dow);
>> const yearFolder = `01 Journals/${now.getFullYear()} Journals`;
>> const monthFolder = `${yearFolder}/${MONTHS[now.getMonth()]}`;
>> const weekFolder = `${monthFolder}/Week of ${ymd(monday)}`;   // journals nest by Monday-based week
>> const path = `${weekFolder}/${today}.md`;
>> if (app.vault.getAbstractFileByPath(path)) {
>>   dv.paragraph(`![[${path}]]`).onclick = () => {
>> 	  app.workspace.openLinkText(path, "", false);
>>   };
>>    
>> } else {
>>   const btn = dv.container.createEl("button", { text: "📓 Create today's journal" });
>>   btn.style.cursor = "pointer";
>>   btn.onclick = async () => {
>>     // Ensure the Monday-nested week folders exist before creating the note
>>     for (const f of [yearFolder, monthFolder, weekFolder]) {
>>       if (!app.vault.getAbstractFileByPath(f)) { try { await app.vault.createFolder(f); } catch (e) {} }
>>     }
>>     // Create from the Templater template so <% %> tags resolve in the new file's context
>>     const tmplPath = "Templates/(C) Daily Note Template.md";
>>     const tmpl = app.vault.getAbstractFileByPath(tmplPath);
>>     const folder = app.vault.getAbstractFileByPath(weekFolder);
>>     const tp = app.plugins.plugins["templater-obsidian"];
>>     if (tp && tmpl) {
>>       await tp.templater.create_new_note_from_template(tmpl, folder, today, true);
>>     } else {
>>       // Fallback if Templater is unavailable: empty file
>>       await app.vault.create(path, "");
>>       app.workspace.openLinkText(path, "", false);
>>     }
>>   };
>> }
>> ```
>
>> [!note] 🕐 Recent
>>
>> ```dataviewjs
>> // ===== Recent — newest non-AI files & chats (excludes (C), wiki, Progress, Plans) =====
>> // Built with direct DOM (not dv.list) to avoid Dataview's RawMarkdown renderer.
>> const recent = dv.pages()
>>   .where(pg =>
>>     !pg.file.name.startsWith("(C)") &&
>>     !pg.file.folder.startsWith("wiki") &&
>>     !pg.file.folder.includes("Progress") &&
>>     !pg.file.folder.startsWith("Plans") &&
>>     pg.file.name !== "index" && pg.file.name !== "log")
>>   .sort(pg => pg.file.mtime, "desc")
>>   .limit(7);
>> const ul = dv.container.createEl("ul");
>> for (const pg of recent) {
>>   const a = ul.createEl("li").createEl("a", { text: pg.file.name, cls: "internal-link" });
>>   a.onclick = (e) => { e.preventDefault(); app.workspace.openLinkText(pg.file.path, "", false); };
>> }
>> if (recent.length === 0) dv.paragraph("*No recent files.*");
>> ```

---
**🗂 Projects**
```base
views:
  - type: table
    name: Projects
    filters:
      and:
        - note.type == "overview"
        - note.tags.contains("project")
    order:
      - file.name
      - note.updated
    sort:
      - property: note.updated
        direction: DESC
```
---
**Project Progress**
```dataview
TABLE WITHOUT ID list(rows.file.link[0], rows.file.link[1]) AS entry, list(rows.summary[0], rows.summary[1]) AS summary, project FROM #progress WHERE project != null SORT date DESC GROUP BY project
FLATTEN entry
``` 

---
**🧮 LeetCode Tracker**
```dataview
TABLE WITHOUT ID file.link AS Problem, difficulty AS Difficulty, solve_time AS "⏱ Solve time", runtime_beats AS "⚡ Runtime", memory_beats AS "💾 Memory", solved AS Solved
FROM "Projects/Google Interview Prep/Ideas/Leetcode"
WHERE solved
SORT solved DESC
```
