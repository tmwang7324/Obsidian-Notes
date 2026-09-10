# (C) Reverse Spell

> BlackRock OA problem — 小红书 report ("OA+三轮Onsite", Q1). Source embedded below.

#### Programming Challenge Description:
Given any string as an input, spell it out in reverse order, lower-case it and separate each
character by hyphen. The output string should contain only letters and numbers. You should
ignore all other non-alphanumeric characters.

### Input:
Any string (eg: "butterfly"). You can assume that the input will never be null.

### Output:
Reversed order of the input string (eg: "y-l-f-r-e-t-t-u-b").

Examples:
```text
Hip, hip, hooray!  -> y-a-r-o-o-h-p-i-h-p-i-h
Brooklyn 99        -> 9-9-n-y-l-k-o-o-r-b
```

![[BlackRock OA+三轮Onsite，难度比较高_4_数据Gold矿工咨询_来自小红书网页版 (2).jpg]]

## Pattern / Hint
- **Pattern:** pure string manipulation — reverse, filter, transform, join.
- **Watch out:** walk the string in reverse, keep only `isalnum()` chars, lower-case each,
  then `'-'.join(...)`. Non-alphanumerics (spaces, punctuation) are dropped, not hyphenated.

## My Approach
<!-- your reasoning here -->

## Solution
```python
import sys
# your solution here
```
