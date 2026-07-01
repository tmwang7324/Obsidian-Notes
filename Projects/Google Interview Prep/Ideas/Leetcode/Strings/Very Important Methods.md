# Python
## join
The `str.join()` method combines elements of an iterable such as a list, tuple, or set into a single string, using a specified separator string between each element.
Ensure that **the method is called on the separator string itself.**

***Warning:*** The `str.join()` method **only** works if all elements inside the iterable are strings. If you have integers, floats, or booleans, Python will crash and raise a `TypeError`
```python
"separator".join(iterable)
## example
arr = ["1", "2", "5", "3"]
print("->".join(arr)) # => "1->2->5->3"

```