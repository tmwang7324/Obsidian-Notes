# (C) Set Intersection

> BlackRock OA problem — 小红书 report ("OA 简直白给", Q2). Source embedded below.

#### Programming Challenge Description:
Find the intersection of two sorted lists of integers.

### Input:
Your program should read lines of text from standard input. Each line will contain two
comma-separated lists of integers in ascending order, one pair of lists per line. The lists
are separated by a semicolon.

### Output:
For each pair of input lists, print to standard output their sorted intersection in
ascending order, comma separated, one intersection per line.

Examples:
```text
Input: 1,2,3,4;4,5,6           -> Output: 4
Input: 7,8,9;8,9,10,11,12      -> Output: 8,9
```

![[BlakRock OA简直白给！不要太简单了_2_AC客_来自小红书网页版.jpg]]

## Pattern / Hint
- **Pattern:** both lists are already sorted → **two-pointer merge** intersection in O(n+m).
- **LC analog:** Intersection of Two Arrays II (LC 350).
- **Watch out:** split each line on `;` first, then each side on `,`. Preserve ascending
  order in the output; handle an empty intersection.

## My Approach
<!-- your reasoning here -->

## Solution
```python
import sys
# your solution here
```
