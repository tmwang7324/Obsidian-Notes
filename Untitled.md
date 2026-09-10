```base
views:
  - type: table
    name: Table
    order:
      - file.name
      - author
    sort:
      - property: file.backlinks
        direction: DESC
  - type: table
    name: View
    order:
      - file.name
      - file.basename
      - file.ext

```