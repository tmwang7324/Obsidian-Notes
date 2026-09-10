---
type: concept
aliases: ["Python Dictionaries", "dict"]
tags: [python, stdlib, data-structures, hashing, concept]
updated: 2026-06-12
sources: 1
---

# Python Dictionaries

A **dictionary** stores **key–value pairs**. Under the hood it's a **hash table**: keys are mapped onto values via a hash function (CPython uses **SipHash** for strings/bytes), giving average **O(1)** lookup, insert, and delete.

## Constructing one

```python
my_dictionary = dict()                          # empty
my_dictionary = dict({"name": "thomas"})        # from another dict
```

From paired iterables — zip a list of keys with a list of values:

```python
keys   = ["names", "professions"]
values = ["thomas", "software"]
combined = dict(zip(keys, values))              # {'names': 'thomas', 'professions': 'software'}
```

## Hashing (the engine underneath)

> A **hash function** maps data of arbitrary size onto fixed-size values. — *Wikipedia*

Call the built-in `hash()` on any hashable object to see it:

```python
hash("Hash me? No, hash you!")   # -> 2948948632693938043
hash("hi")                       # -> 6035979163977027719
```

No matter how long the input, the output is a fixed-width integer. That fixed-size hash is what lets a dict jump straight to a key's slot instead of scanning. Only **hashable** (effectively immutable) objects can be dict keys — lists can't, tuples of immutables can.

## Related

- [[(C) Python Counter|Python Counter]] — a `dict` subclass that counts frequencies.
- Source: `raw/notes/Dictionaries.md` *(its `## Defaultdict` section was an empty stub at synthesis time — not yet captured.)*
