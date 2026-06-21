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
## Defaultdict

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