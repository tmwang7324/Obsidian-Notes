# (C) Happy Numbers

> BlackRock OA problem — 小红书 report ("先解决代码再给思路", Q2). Source embedded below.

#### Programming Challenge Description:
A happy number is defined by the following process. Starting with any positive integer,
replace the number by the sum of the squares of its digits, and repeat the process until
the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not
include 1. Those numbers for which this process ends in 1 are happy numbers, while those
that do not end in 1 are unhappy numbers.

### Input:
Your program should read lines of text from standard input. Each line contains a single
positive integer, N.

### Output:
If the number is a happy number, print 1 to standard output. Otherwise, print 0.

Examples:
```text
7  is happy:      7 -> 49 -> 97 -> 130 -> 10 -> 1
22 is NOT happy:  22 -> 8 -> 64 -> 52 -> 29 -> 85 -> 89 -> 145 -> 42 -> 20 -> 4 -> 16 -> 37 -> 58 -> 89 ...
```

![[blackrock OA搞定，先解决代码再给思路！_2_mathitdd教育_来自小红书网页版.jpg]]

## Pattern / Hint
- **Pattern:** iterate the digit-square-sum; detect the non-1 cycle.
- **LC analog:** Happy Number (LC 202).
- **Watch out:** use a `seen` set (or Floyd's fast/slow pointers) to break the loop —
  return 1 if you reach 1, 0 if you revisit a number. One result per input line.

## My Approach
<!-- your reasoning here -->

## Solution
```python
import sys
# your solution here
```
