A stack is a list data structure that follows a **LIFO** (Last In First Out) policy for removing items.

## Python
Same initialization as a regular list in Python. `stack = []`
```python
pop = stack.pop()
stack.append()
peek = stack[-1]
```
## Typescript
```typescript
class Stack<T> {
	private items: T[] = [];
	
	// Add an item to the top of  the stack
	push (element: T) void {
		this.items.push(element);
	};
	
	peek () T {
		return this.items[-1]
	} 
	
	
}
```

# Monotonic Stack
This is a very common and useful design pattern for stacks. It involves maintaining a strictly increasing order of elements within the stack but from right to left.

If an incoming element is greater than the top, pop the top of the stack until the incoming element is less than the top or the stack is empty. Append the incoming element.
