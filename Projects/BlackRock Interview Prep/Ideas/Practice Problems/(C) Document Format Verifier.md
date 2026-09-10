# (C) Document Format Verifier

> BlackRock OA problem (reported screenshot). Source embedded below.

#### Programming Challenge Description:
You are writing a program to analyze the financial data for a set of companies. Your
coworker gives you a text file of company data. However, you are worried that your
coworker didn't type the data in correctly. Write a program that will tell you if the
data is correctly formatted.

The data looks like:
```text
[
  {
    company_name: (BlackRock)
    ticker: (BLK)
    stock_price: {
      2022-04-03: ($930)
      2022-04-02: ($932)
    }
  },
  {
    company_name: (Apple)
    ticker: (APPL)
    stock_price: {
      2022-04-03: ($175)
      2022-04-02: ($178)
    }
  }
]
```
A file is formatted correctly if each opening parenthesis `{ [ (` is closed out with its
respective "closing" parenthesis `} ] )`. **The open bracket `(` matches `)` on the same
line**, however `[` `]` and `{` `}` may match over multiple lines. (Statement continued
past the screenshot crop — output spec cut off; infer: report whether the data is valid.)

### Input:
The text file / stdin containing the company data as shown above.

### Output:
Whether the document is correctly formatted (truncated in screenshot — confirm exact
output format when solving).

![[Pasted image 20260706185351.png]]

## Pattern / Hint
- **Pattern:** stack-based bracket matching, with a *line-scoping* twist — `()` must open
  and close on the same line; `[]`/`{}` may span lines.
- **LC analog:** Valid Parentheses (LC 20), extended.
- **Watch out:** track the line number when you push `(`; if you hit a newline before its
  `)`, it's malformed. Non-bracket chars are ignored.

## My Approach
<!-- your reasoning here -->

## Solution
```python
import sys
# your solution here
```
