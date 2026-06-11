# Callout metadata — an arbitrary string you put after a pipe in the callout header:
  > "[!blank|wide-1]"
          ^^^^^^  ← this is the metadata, not YAML

  The syntax is > [!TYPE|METADATA] Optional Title. It's an Obsidian callout feature, unrelated to YAML.

  How CSS can then target it: when Obsidian renders a callout, it emits HTML like this:
  <div class="callout" data-callout="blank" data-callout-metadata="wide-1">
  - The type (after !, lowercased) becomes the data-callout attribute.
  - Everything after the | becomes the data-callout-metadata attribute.

  That's the whole trick the MCL snippet relies on. Look back at line 166 of MCL Multi Column.css:
  div[data-callout="multi-column"].callout > .callout-content > div[data-callout-metadata*="wide-2"] { flex-grow: 2; }
  It's a plain CSS attribute selector (*= means "contains") matching that data-callout-metadata string. So
  [!blank|wide-1] is just you stuffing a value into an HTML attribute that a stylesheet then keys off of. You can pile
  several on with more pipes/spaces too — e.g. [!blank|wide-2 center] → data-callout-metadata="wide-2 center", and both
  *="wide-2" and *="center" selectors will match.



So: frontmatter = note-level YAML; callout metadata = a post-pipe tag that becomes a CSS-targetable HTML attribute. Different layers.
 Here's the chain:
