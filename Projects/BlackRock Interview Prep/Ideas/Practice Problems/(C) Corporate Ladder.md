# (C) Corporate Ladder

> BlackRock OA problem — 小红书 report ("先解决代码再给思路", Q1). Source embedded below.

#### Programming Challenge Description:
A company wants to track change in their organization by knowing how many levels exist
between any two employees. This number will help them know who is being promoted and who
is not.

For example: If Susan reports to John and John reports to Amy, then there are 2 levels
between Susan and Amy.

Write a program that will tell you how many levels exist between any two names in a
hierarchy of employees. The program must read a list of name pairs that represent an
employee and their manager.

**HINT:** The two names to compare may be in different parts of the organizational tree and
not have a direct managerial line.

### Input:
The first line of input will be a pair of names to compare. All subsequent lines will be
employee/manager pairs. The company's complete hierarchy will be included so no incomplete
trees will exist.

For example:
```text
Susan/Amy
Susan/John
John/Amy
```

### Output:
The number of levels between the two names.

![[blackrock OA搞定，先解决代码再给思路！_1_mathitdd教育_来自小红书网页版.jpg]]

## Pattern / Hint
- **Pattern:** build the org tree/graph from `employee/manager` pairs, then find the
  distance between the two nodes. Since they may be in different subtrees, this is a
  **lowest-common-ancestor / undirected-BFS** distance, not just a straight climb.
- **Watch out:** treat edges as undirected for the BFS distance, or find the LCA and sum
  the two depths minus twice the LCA depth. Parse `A/B` on the `/`.

## My Approach
<!-- your reasoning here -->

## Solution
```python
import sys
# your solution here
```
