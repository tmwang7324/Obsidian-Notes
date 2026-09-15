---
tags: [matrix, medium]
status: Not started
difficulty: Medium
solved:
---

# Rotate Matrix (M)

Given a square `n x n` matrix and a number of turns, rotate the matrix **90 degrees
counterclockwise** for each turn and return the resulting matrix. Elements on the **main diagonal**
(`r == c`) and **anti-diagonal** (`r + c == n - 1`) do not move. Constraints: `1 <= n <= 100`,
`0 <= turns`.

```
Original:              One turn (90 CCW):
1 2 3                  1 6 3
4 5 6       --->       2 5 8
7 8 9                  7 4 9
```

Diagonal positions (1, 3, 5, 7, 9) stay fixed. Only 2, 4, 6, 8 rotate.

## Target complexity
**O(n^2)** per rotation — every cell must move, so you can't do better than touching all `n^2`
elements. With the `turns % 4` optimization, at most 3 rotations are ever performed, so the total
is still **O(n^2)**.

## My approach
_Re-derive the pattern here before re-reading the solution._

### Solution
```python
def solution(matrix, turns):
    n = len(matrix)
    turns %= 4  # Four 90-degree rotations return to the original matrix.

    for _ in range(turns):
        rotated = [row[:] for row in matrix]

        for r in range(n):
            for c in range(n):
                if r != c and r + c != n - 1:
                    # 90-degree counterclockwise rotation:
                    # old[r][c] moves to new[n - 1 - c][r]
                    rotated[n - 1 - c][r] = matrix[r][c]

        matrix = rotated

    return matrix
```

## Reasoning to the approach
The key insight is figuring out where each cell lands after a 90-degree counterclockwise rotation.

Picture the top-right corner `matrix[0][n-1]`. After rotating CCW, it moves to the top-left:
`rotated[0][0]`. Generalizing: `matrix[r][c]` moves to `rotated[n - 1 - c][r]`.

Verify with a 3x3 example:
- `matrix[0][0] = 1` -> `rotated[2][0] = 1` (bottom-left)
- `matrix[0][2] = 3` -> `rotated[0][0] = 3` (top-left)
- `matrix[2][0] = 7` -> `rotated[2][2] = 7` (bottom-right)

Since four 90-degree rotations return to the original, `turns % 4` avoids redundant work.

## Naive solution — and why it fails
Perform the rotation `turns` times without reducing modulo 4:

```python
def solution(matrix, turns):
    n = len(matrix)
    for _ in range(turns):
        rotated = [[0] * n for _ in range(n)]
        for r in range(n):
            for c in range(n):
                rotated[n - 1 - c][r] = matrix[r][c]
        matrix = rotated
    return matrix
```

**Why it fails:** If `turns = 10^9`, this loops a billion times at **O(n^2)** each — completely
intractable. The fix: `turns % 4` reduces it to at most 3 rotations.

## Common pitfalls

**1. Forgetting `turns % 4`.**
Without it, large turn counts cause TLE. Four 90-degree rotations are an identity transform.

**2. Mixing up clockwise vs. counterclockwise mappings.**
- **CCW:** `rotated[n - 1 - c][r] = matrix[r][c]` 
- **CW:** `rotated[c][n - 1 - r] = matrix[r][c]`

These are easy to confuse. Verify with a single corner element.

**3. Mutating the matrix in-place while reading from it.**
If you write directly into `matrix` instead of a fresh `rotated` array, you overwrite cells that
haven't been read yet. Either use a separate array or do the four-way cyclic swap (see optimal
solution).

## Optimal solution
Avoid allocating a new matrix by decomposing rotation into two in-place operations:

**Counterclockwise 90:** transpose, then reverse each column (i.e., reverse the row order).

```python
def solution(matrix, turns):
    n = len(matrix)
    turns %= 4

    for _ in range(turns):
        # Transpose in-place
        for r in range(n):
            for c in range(r + 1, n):
                matrix[r][c], matrix[c][r] = matrix[c][r], matrix[r][c]

        # Reverse row order (reverses each column)
        matrix.reverse()

    return matrix
```

**Why this works:** A transpose swaps rows and columns (`matrix[r][c] <-> matrix[c][r]`).
Reversing the row order after that is equivalent to reflecting across the horizontal midline.
The composition of these two reflections equals one 90-degree CCW rotation.

```
Original    Transpose    Reverse rows
1 2 3       1 4 7        3 6 9
4 5 6  -->  2 5 8   -->  2 5 8
7 8 9       3 6 9        1 4 7
```

For **clockwise 90**, transpose then reverse each row instead:
```python
for row in matrix:
    row.reverse()
```

## Complexity
- **Time:** O(n^2) — transpose is O(n^2), reversing rows is O(n^2), done at most 3 times.
- **Space:** O(1) for the in-place version, O(n^2) for the new-array version.

## Master-check
Why does `turns % 4` work — what property of 90-degree rotations makes four of them an identity?
Derive the clockwise mapping `rotated[c][n - 1 - r] = matrix[r][c]` from scratch using a 3x3
example.
