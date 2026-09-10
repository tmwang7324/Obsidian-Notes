# (C) Cash Register

> BlackRock OA problem — 小红书 report ("OA+三轮Onsite", Q2). Source embedded below.

#### Programming Challenge Description:
The goal of this question is to design a cash register program. Your register currently has
the following notes/coins within it:

```text
One Pence:    .01      One Pound:    1
Two Pence:    .02      Two Pounds:   2
Five Pence:   .05      Five Pounds:  5
Ten Pence:    .10      Ten Pounds:   10
Twenty Pence: .20      Twenty Pounds: 20
Fifty Pence:  .50      Fifty Pounds: 50
```

The aim of the program is to calculate the change that has to be returned to the customer
with the least number of coins/notes. Note that the expectation is to have an
**object-oriented solution** — think about creating classes for better reusability.

### Input:
Your program should read lines of text from standard input (this is already part of the
initial template). Each line contains two numbers which are separated by a semicolon. The
first is the Purchase price (PP) and the second is the cash (CH) given by the customer.

### Output:
For each line of input print a single line to standard output which is the change to be
returned to the customer. If `CH == PP`, print out `Zero`. If `CH > PP`, print the amount
that needs to be returned (in terms of the currency values). Any other case where the
result is an error, the output should be `ERROR`.

![[BlackRock OA+三轮Onsite，难度比较高_4_数据Gold矿工咨询_来自小红书网页版 (2).jpg]]

## Pattern / Hint
- **Pattern:** greedy change-making against a *canonical* denomination set (greedy is
  optimal here) → emit the fewest notes/coins.
- **Watch out:** work in **integer pence** (multiply by 100 and round) to dodge float
  error. `CH == PP` → `Zero`; `CH < PP` → `ERROR`. Design it OO (a `Denomination` /
  `Register` class) since the prompt rewards reusable structure.

## My Approach
<!-- your reasoning here -->

## Solution
```python
import sys
# your solution here
```
