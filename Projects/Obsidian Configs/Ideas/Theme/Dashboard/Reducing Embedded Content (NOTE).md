# Limit Embed Height
Use a CSS snippet to limit the height embedded content can take using: 
```css
.markdown-embed * {
max-height: 200px;
}

```
This code also adds a sidebar so that one can scroll through the content.

# Disable Recursive Embedded Content

# Block Linking
A block is aunit of text in my note, such as a paragraph, block quote, or list item.

I can link to a block by adding `#^` at the end of my link destination, followed by a unique block identifier: [[Overview#^f41140]].

Fortunately, I don't need to manually find the identifier---when I type the caret (`^`), a list of suggestions will appear, allowing me to select the correct block.


