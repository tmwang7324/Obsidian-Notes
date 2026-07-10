# (C) Set Matching (Alphanumeric)

> BlackRock OA problem — 小红书 report ("最新通过 BlackRock OA 两题", Q2). Source embedded below.

#### Programming Challenge Description:
Write a program that accepts two sets of alpha-numeric characters and performs an efficient
matching between them. Finally, display the results.

The intent of this challenge is to play with set theory. **Avoid using pre-built framework
functions that perform this work in a single line of code.** Instead, illustrate how you
would efficiently operate with two sets of data when trying to match values between them.
There are many ways to approach this algorithm so be creative.

### Input:
Two lines of input, each with a space-delimited series of values that represent the two
sets.

For example:
```text
1 2 3 A B C
X 11 G M 2 9 3 C N R
```

### Output:
The set of values that exist in **both** sets, sorted alphabetically. (Example output
partly cropped — for the input above the common values are `2 3 C`.) If no common values
exist, output an empty/`NULL`-style result (confirm exact spec when solving).

![[最新通过BlackRock OA 两题_2_bug克星_来自小红书网页版.jpg]]

## Pattern / Hint
- **Pattern:** set intersection built by hand — hash one set, probe with the other.
- **LC analog:** Intersection of Two Arrays (LC 349).
- **Watch out:** the "no pre-built one-liner" constraint means implement the membership
  check yourself (dict/set insert + lookup), then sort the result.

## My Approach
<!-- your reasoning here -->

## Solution
```python
import sys
# your solution here
```
