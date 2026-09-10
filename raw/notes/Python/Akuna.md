# Overview
Very useful stuff

## Questions
1. ```python
   def f(x, arr=[]):
	   arr.append(x)
	   return arr
	print(f(1), f(2)) # => [1], [1, 2]
   ```
2. 
   ```python
   class Base:
	   self.items = []
	class A(Base):
		pass
	class B(Base):
		pass
	A.items.append(1)
	B.items.append(2)
   ```
3. Yield vs Return
4. Enum convention for global constants
5. tuples can be used as dict indices
6. @abstractmethod with `abc` inheritance. Direct class instantiation results in error
7. ```python
   func = []
   for i in range(3):
	   func.append(lambda: i)
	print(f() for f in func) # => [2, 2, 2] 
   ```
   ```python
   import copy
   a = [[1,2], [3,4]]
   b = copy.copy(a)
   b[0].append(99)
   print(a[0])
   ```
8. @staticmethod vs @classmethod
9. The Python GIL 
10. For CPU governed parallel tasks, use multithreading
11. why is it bad to apply large amounts of concatenation? *because concatenating a string involves creating a new object $O(n^2)$ space*
12. **list equality** ***`a == b`***
13. How do sequential `except` blocks work? The first `except` triggered blocks the rest.
14. When to use a `dataclass field` over regular variable assignment:  
15. ```python
    @dataclass
    class fruit
	    features 
    ``` 
- **Mutable Default Values:** Use `field(default_factory=list)` instead of `= []` to avoid sharing the same list instance across all class objects.
- **Hiding from Output:** Use `field(repr=False)` to keep secret or noisy data out of the automatically generated string representation.
- **Read-Only or Calculated Values:** Use `field(init=False)` to create an attribute that is not accepted in the `__init__` constructor method.
- **Adding Metadata:** Use `field(metadata={'unit': 'kg'})` to store extra data about a variable for documentation or validation tools.

    
    
15. lru cache
16. What are `__start__` and `__exit__`
17. `NamedTuple` object
18. `json.dump` an object will result in an error
19. `*args, **kwargs` split the call of a function into positioned tuple arguments and keyword dict arguments
```python
def f(*args, **kwargs):
	print(*args)
	print(**kwargs)
f(1,2,3,"hello":"world", 4: "apple") # => (1, 2, 3)
									 # => (world, apple) 
```
20. Integer caching (`is` vs `==`): CPython caches integers -5 to 256. Beyond that range, `is` compares identity (different objects), not value.
   ```python
   a = 256; b = 256
   c = 257; d = 257
   print(a is b, c is d)  # => True, False
   ```
21. Chained comparison gotcha: Python chains comparisons, so `False == False in [False]` becomes `(False == False) and (False in [False])` — both True.
   ```python
   print(False == False in [False])  # => True
   ```
22. `for/else` — the `else` clause fires on normal loop completion (no `break`), not on "the loop body was falsy."
   ```python
   for x in [1, 2, 3]:
       if x == 5: break
   else:
       print("no break")
   # => prints "no break"
   ```
23. Generator exhaustion: generators are single-pass iterators. Once consumed past an element, it can't be found again.
   ```python
   g = (x for x in [1, 2, 3])
   print(3 in g)   # => True
   print(2 in g)   # => False
   ```
24. Truthy containers vs truthy contents: an empty list is falsy, but a list *containing* a falsy value is still truthy — truthiness checks the container's length, not its elements.
   ```python
   print(bool([]))       # => False
   print(bool([0]))      # => True
   print(bool([[]]))     # => True
   ```