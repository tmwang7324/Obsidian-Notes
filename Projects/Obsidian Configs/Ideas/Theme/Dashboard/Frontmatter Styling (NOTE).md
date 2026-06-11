# Creating a Frontmatter
1. Type "---" on the first line of the note.
2. Choose properties to set.
# Frontmatter Styling
The MCL snippet specifies that !multi-column can be styled using the cssClass: dashboard attribute on the frontmatter.
To enable the styling, create a YAML frontmatter section at the top of the file and write a customized css class into the cssClass field.
	
Here's the chain:
1. **cssclasses** is a reserved Obsidian frontmatter key. When Obsidian renders a note that has it, it takes each value
	  and slaps it as a literal CSS class onto the note's root view container — not onto any individual block. So your
	  dashboard note renders roughly as:
	  ```html 
	  <div class="markdown-preview-view ... dashboard">   ← class lands HERE (reading view)
	     <div class="block-language-dataviewjs"> … .dash-clock … </div>
	     <div class="callout" data-callout="multi-column">
	        <div class="callout" data-callout="blank" data-callout-metadata="wide-1"> … </div>
	     </div>
	     <div class="block-language-base"> … </div>
	  </div>
	  ```
	  (In Live Preview the container is .markdown-source-view instead; Obsidian adds the class to both, which is why the
	  styling holds in either view.)
	
2. My selectors use a space — the descendant combinator. Look at the snippet:
	  `.dashboard .callout[data-callout="multi-column"] .callout[data-callout*="blank"] { … }`
	  The space between .dashboard and .callout means "any .callout nested anywhere inside an element that has the
	  .dashboard class." The callout never needs the class itself — it just needs to live inside the element that does. Same
	  mechanism for .dashboard .dash-clock and .dashboard .block-language-base.
	
	  So it's a containment relationship: cssclasses: dashboard brands the whole note's wrapper, and every widget inside is
	  reachable as a descendant of that wrapper. That's also why this styling is scoped — those exact selectors can't match
	  callouts in any other note, because no other note's wrapper carries .dashboard.
	
	  Quick way to see it yourself: open the dashboard, hit Ctrl+Shift+I (devtools), and inspect the outer note <div> — you'll spot dashboard sitting      in its class list alongside Obsidian's own classes.


