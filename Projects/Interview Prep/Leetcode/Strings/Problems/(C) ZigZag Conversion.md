---
tags: [strings, medium]
status: Not started
leetcode: 6
difficulty: Medium
solved:
---

# (C) ZigZag Conversion (M) — LC 6

Given a string `s` and an integer `numRows`, arrange the characters in a zigzag pattern across
`numRows` rows, then read off each row left-to-right to produce the result. Example:
`s = "PAYPALISHIRING"`, `numRows = 3` →

```
P   A   H   N
A P L S I I G
Y   I   R
```

→ `"PAHNAPLSIIGYIR"`. Constraints: `1 ≤ s.length ≤ 1000`, `1 ≤ numRows ≤ 1000`.

## Target complexity
The string has length `n`. You must visit every character exactly once → **O(n)** time is optimal.
No approach can beat that. The question is whether you achieve it cleanly.

## My approach
_Re-derive the pattern here before re-reading the solution._
#### Using mod to determine row indices
I already saw this problem a week ago, so I was predisposed to think about only building row strings instead of a full 2-D matrix. However, I started off trying to use modular arithmetic to determine the index of the row to append.

```python
# 
row[i % numRows] = s[i]

numRows = 3
'''
0 1 2 3 4 5
P A Y P A L   

P   A
A P L 
Y
```
This does only works for the first down column and up diag pattern because the last character of the diagonal is the first character of the next down column.

#### Traversing down and up within a while loop



## Reasoning to the approach
Visualize the zigzag: characters fill rows top-to-bottom (the downstroke), then bottom-to-top
skipping the first and last rows (the diagonal). This repeats. Two clean ways to exploit it:

1. **Row-bucket simulation** — walk through `s`, tracking which row the current character belongs
   to and a direction flag that flips at row 0 and row `numRows - 1`. Append each character to
   its row's bucket. Concatenate all buckets at the end.

2. **Index-math** — compute the cycle length (`2 × numRows − 2`) and directly calculate which
   characters land in each row. Row 0 and the last row contribute one character per cycle;
   middle rows contribute two (one from the downstroke, one from the diagonal).

The simulation is easier to get right under interview pressure. The index-math approach avoids building row buckets but is harder to derive without mistakes.

## Naive solution — and why it's suboptimal
Build a 2D grid of width `n` and simulate the zigzag by placing characters at `(row, col)`
coordinates, then scan the grid row by row:

```python
def convert(s, numRows):
    if numRows == 1:
        return s
    n = len(s)
    grid = [['' for _ in range(n)] for _ in range(numRows)]
    row, col, idx = 0, 0, 0
    while idx < n:
        while row < numRows and idx < n:        # downstroke
            grid[row][col] = s[idx]
            row += 1
            idx += 1
        row -= 2
        col += 1
        while row > 0 and idx < n:              # diagonal
            grid[row][col] = s[idx]
            row -= 1
            col += 1
            idx += 1
    return ''.join(grid[r][c] for r in range(numRows) for c in range(n) if grid[r][c])
```

**Why it's suboptimal:** allocates an `O(numRows × n)` grid that's mostly empty — wasteful in
space and in the final scan. The actual content is still O(n) characters, so the grid buys
nothing over row buckets.
## Optimal solution — row-bucket simulation
```python
def convert(s: str, numRows: int) -> str:
    if numRows == 1 or numRows >= len(s):
        return s

    rows = [''] * numRows
    cur_row = 0
    going_down = False

    for ch in s:
        rows[cur_row] += ch
        if cur_row == 0 or cur_row == numRows - 1:
            going_down = not going_down
        cur_row += 1 if going_down else -1

    return ''.join(rows)
```

One pass through `s`, each character appended to the correct row bucket. The direction flag
`going_down` flips at both boundaries. Final concatenation is O(n).

## Common pitfalls

**1. Forgetting the `numRows == 1` base case.**
When `numRows == 1`, the cycle length is `2 × 1 − 2 = 0`, causing a division-by-zero or infinite
loop. Guard it: if `numRows == 1`, return `s` immediately.

**2. Off-by-one on direction flip.**
The direction flips **when you reach** row 0 or row `numRows - 1`, not after. A common bug is
flipping one step late, writing a character to row `-1` or row `numRows`.

**3. Forgetting middle rows get two characters per cycle (index-math approach).**
Row 0 and the last row each contribute one character per cycle. Every middle row `r` contributes
two: index `cycle × k + r` (downstroke) and `cycle × (k+1) − r` (diagonal). Missing the second
index drops half the characters in middle rows.



### Alternative — index-math (no row buckets)
```python
def convert(s: str, numRows: int) -> str:
    if numRows == 1 or numRows >= len(s):
        return s

    n = len(s)
    cycle = 2 * numRows - 2
    result = []

    for row in range(numRows):
        for k in range(0, n, cycle):
            idx = k + row
            if idx < n:
                result.append(s[idx])
            if 0 < row < numRows - 1:       # middle rows have a diagonal char
                diag = k + cycle - row
                if diag < n:
                    result.append(s[diag])

    return ''.join(result)
```

Same O(n) time and O(n) space, but builds the result directly by row without intermediate
buckets.

## Complexity
- **Time:** O(n) — every character visited exactly once.
- **Space:** O(n) — the output string (row buckets or result list hold the same n characters).

## Master-check
Can you derive the cycle length `2 × numRows − 2` from scratch? For the index-math approach,
explain why the diagonal character in middle row `r` is at index `k + cycle − r` — draw it out.
