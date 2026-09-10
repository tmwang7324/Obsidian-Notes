# Overview

In Python, a dictionary is a data structure that stores key-value pairs. They are fundamentally hash tables that efficiently map keys onto values using the SipHash algorithm. 

Initializing an empty dictionary:
```python
my_dictionary = dict()
```
Initializing a dictionary with the first key-value pair being `{"name": "thomas"}`:
```python
my_dictionary = dict({"name": "thomas"})
```
From paired iterables: Use `dict()` and `zip()` to merge a list of keys and values:
```python
fields = ["names", "professions"]
values = ["thomas", "software"]
combined = dict(zip(keys, values))
```
## Type Control
Use brackets to define the type of a dictionary's keys and values:
```python
```
## setdefault

`dict.setdefault(key, default)` returns the value if `key` exists; otherwise inserts `key` with `default` and returns `default`.

```python
counts = {}
counts.setdefault("a", 0)  # inserts "a": 0, returns 0
counts.setdefault("a", 99) # "a" already exists, returns 0
```

Common use — building a dict of lists without checking membership:
```python
groups = {}
for item in data:
    groups.setdefault(item.category, []).append(item)
```

Note: `setdefault` allocates the default object on every call, even when the key already exists. For cheap defaults (`0`, `[]`) this is negligible, but expensive-to-construct defaults are wasted work on hits.

## Defaultdict

`collections.defaultdict` does the same thing automatically — the default factory is invoked at the C level on missing keys, avoiding a Python-level method call per access:

```python
from collections import defaultdict
groups = defaultdict(list)
for item in data:
    groups[item.category].append(item)
```

**`defaultdict` vs `setdefault` performance:** nearly identical, but `defaultdict` is ~10-30% faster in tight loops with many misses (one C-level call vs two Python method calls, and it only calls the factory on actual misses).

**Pick based on semantics, not speed:**
- `defaultdict` — the whole dict should auto-vivify
- `setdefault` — one-off insertion at a specific call site; rest of the code should `KeyError` on missing keys

## What is Hashing
 According to Wikipedia,
>**A hash function is any function that can be used to map data of arbitrary size onto fixed-size values.**

One can see how this works by dropping into a Python shell and calling the `hash()` built-in function on an object:
```python
hash("Hash me? No, hash you!") -> 2948948632693938043
hash("hi") -> 6035979163977027719
```
As one can see, no matter how long the input string is inside the hash function, the resulting integer output remains the same amount of digits.

## What does Python Use Hashing For?
See more at [[What is Python's Default Hash Algorithm]]



## Spread Operator in Python
To include all key value pairs of an external dict while allowing for more
```python
dict1 = {"field1": "hi", "field2": "world", **dict2}
dict2 = {"field1": "hello", "field3": "!"}
print(dict1) # => {field1: hello, field2: world, field3: !}


```

## Ordered Dict
Uses a doubly linked list under the hood to keep track of the order key value pairs are added or changed in place.