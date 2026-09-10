Counter is a Python object from collections that counts how many times each item appears in a list and returns the counts in a dictionary.
Key = element; Value = frequency

```python 
from collections import Counter
freq = Counter(nums)
```
### Time Complexity


| Action                                              | Time Complexity                   | Space Complexity |     |
| --------------------------------------------------- | --------------------------------- | ---------------- | --- |
| Counter                                             | O(n)                              | O(n)             |     |
| most_common(),<br>most_common(1),<br>most_common(k) | O(n log n),<br>O(n)<br>O(n log k) |                  |     |
|                                                     |                                   |                  |     |

`

