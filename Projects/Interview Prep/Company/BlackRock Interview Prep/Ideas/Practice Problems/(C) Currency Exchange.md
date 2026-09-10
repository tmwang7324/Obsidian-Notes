# (C) Currency Exchange

> BlackRock OA problem (reported screenshot). Source embedded below.
> Note: an empty `Currency.md` placeholder also exists in this folder for this problem.

#### Programming Challenge Description:
Given:
- A list of foreign exchange rates
- A selected currency
- A target currency

Your goal is to calculate the **max** amount of the target currency for 1 unit of the
selected currency through the FX transactions. Assume all transactions are free and done
immediately. If you cannot finish the exchange, return `-1.0`.

### Input:
You will be provided a list of fx rates, a selected currency, and a target currency.

For example:
```text
FX rates list:
  USD to JPY 1 to 109
  USD to GBP 1 to 0.71
  GBP to JPY 1 to 155
Original currency: USD
Target currency : JPY
```

### Output:
The max amount of the target currency you can get.

For example:
```text
USD to JPY -> 109
USD to GBP to JPY = 0.71 * 155 = 110.05 > 109,
```
so the max value will be `110.05`.

![[Pasted image 20260706185830.png]]

## Pattern / Hint
- **Pattern:** weighted directed graph; find the **maximum-product path** from source to
  target. Edge weight = conversion rate; path value = product of edges.
- **LC analog:** Evaluate Division (LC 399) — but maximize the product instead of a single
  lookup. DFS every path, or relax like Bellman-Ford (max instead of min).
- **Watch out:** rates are directional (USD→GBP present doesn't give GBP→USD). Return
  `-1.0` if the target is unreachable. Guard against cycles in DFS.

## My Approach
<!-- your reasoning here -->

## Solution
```python
import sys
# your solution here
```
