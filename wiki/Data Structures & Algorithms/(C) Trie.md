---
type: concept
aliases: ["Trie", "Prefix Tree"]
tags: [dsa, data-structures, strings, interview-prep, concept]
updated: 2026-06-12
sources: 1
---

# Trie

A **trie** (aka **prefix tree**) stores strings as a tree where **each edge is a character** and each root-to-node path spells a prefix. Shared prefixes are stored once — that sharing is the whole point.

Inserting `"car"`, `"cat"`, `"dog"`:

```
        root
       /    \
      c      d
      |      |
      a      o
     / \     |
    r*  t*   g*      ← *  = "a word ends here"
```

`"car"` and `"cat"` share the `c → a` path, then split.

## Node shape & operations

Each node holds (a) a map/array of children (up to 26 for lowercase letters) and (b) an `isEndOfWord` flag.

| Op | What it does | Cost |
|----|--------------|------|
| `insert(word)` | walk/create a node per char, mark last as end | O(L) |
| `search(word)` | walk the chars, check the end flag | O(L) |
| `startsWith(prefix)` | walk the chars, ignore the end flag | O(L) |

The key win: cost is **O(length of the word)** — *independent of how many words are stored*. Prefix-matching against a million words is still just "walk L characters."

## Where it shows up

Autocomplete, spell-check, IP routing. Classic interview problems: *Implement Trie* (LeetCode 208), *Design Add and Search Words*, and *Word Search II* (a grid + trie combo that's genuinely hard).

## Related

- In the [[(C) Google Interview Prep|Google Interview Prep]] curriculum this is scoped **light** — know the structure and code `insert/search/startsWith` once, but don't grind variants (Google asks tries occasionally, not as a signature). See [[(C) Curriculum Strategy|Curriculum Strategy]].
- Source: `Projects/Google Interview Prep/Chats/(C) Setup Google Interview Prep Project.md`
