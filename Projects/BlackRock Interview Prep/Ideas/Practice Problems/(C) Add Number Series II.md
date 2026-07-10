# (C) Add Number Series II

> BlackRock OA problem — 小红书 report ("OA 简直白给", Q1). Source embedded below.

#### Programming Challenge Description:
Write a program that, given an integer N, sums all the whole numbers from 1 through N
(both inclusive). Do not include in your sum any of the intermediate values (1 and N
inclusive) that are divisible by 5 or 7.

### Input:
Your program should read lines from standard input. Each line contains a positive integer.

### Output:
For each line of input, print to standard output the sum of the integers from 1 through n,
disregarding those divisible by 5 and 7. Print out each result on a new line.

Examples:
```text
Input: 10  -> Output: 33   (1+2+3+4+6+8+9;  exclude 5, 7, 10)
Input: 7   -> Output: 16   (1+2+3+4+6;      exclude 5, 7)
```

![[BlakRock OA简直白给！不要太简单了_1_AC客_来自小红书网页版.jpg]]

## Pattern / Hint
- **Pattern:** simple loop / arithmetic; skip any `k` where `k % 5 == 0 or k % 7 == 0`.
- **Watch out:** multiple test lines per run — read until EOF, print one result per line.
  For very large N you can close-form it (sum 1..N minus multiples of 5, minus multiples of
  7, plus multiples of 35), but a loop is fine at OA scale.

## My Approach
<!-- your reasoning here -->

## Solution
```python
import sys
# your solution here
```
