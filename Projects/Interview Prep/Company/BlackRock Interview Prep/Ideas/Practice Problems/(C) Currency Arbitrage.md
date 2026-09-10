# (C) Currency Arbitrage

> BlackRock OA problem — 小红书 report ("OA+三轮Onsite", Currency Arbitrage). Source embedded below.

#### Programming Challenge Description:
An arbitrage is the simultaneous purchase and sale of an asset in order to profit from a
difference in the price. This type of trade exploits price differences between similar or
identical financial instruments, either on different markets or in different forms.

You are a currency trader looking for arbitrage opportunities in the currency market using
these three quotes:
1. The cost of USD per EUR (USD/EUR) for converting USD to EUR.
2. The cost of EUR per GBP (EUR/GBP) for converting EUR to GBP.
3. The cost of GBP per USD (GBP/USD) for converting GBP to USD.

You must use your USD to buy EUR, then use your EUR to buy GBP, and finally use your GBP to
buy USD, resulting in some sort of profit or loss (i.e., USD to EUR to GBP to USD). Reverse
trading is **not allowed**, so you are limited to the 3 exchanges in the direction shown
above. For example, you can convert USD to EUR (selling US Dollars and buying Euros); you
cannot invert the fraction to sell Euros and buy US Dollars.

Given **100,000 USD** for each trade, calculate the arbitrage profit truncated to whole
dollars (USD); otherwise, print `0` if there is no arbitrage opportunity.

### Input:
The locked stub code reads the following from stdin and passes it to your function:
- The first line contains a single integer, N, denoting the number of quotes.
- Each of the N subsequent lines describes a quote as three space-separated floats:
  1. price quote for USD/EUR
  2. price quote for EUR/GBP
  3. price quote for GBP/USD

Your function takes a string array parameter containing each of the N lines, in order.

**Constraints:** `1 <= N <= 1000`, `0.001 < quotes <= 1000`.

### Output:
The arbitrage profit truncated to whole dollars, else `0`. (Output format cropped at 1/3 —
confirm whether it's per-line or the best across the N quotes.)

![[BlackRock OA+三轮Onsite，难度比较高_2_数据Gold矿工咨询_来自小红书网页版 (1).jpg]]

## Pattern / Hint
- **Pattern:** arithmetic on a fixed 3-step conversion cycle — no graph search needed.
- **The tricky part is the direction of each quote.** "USD per EUR" = how many USD buy 1
  EUR, so converting *out of* USD divides by that rate. Following USD→EUR→GBP→USD, the
  ending USD works out to `100000 / (q1 * q2 * q3)` — reason it through carefully rather
  than trusting a multiply. Profit only if the round-trip ends above 100,000; then
  truncate (`int()`), else print `0`.
- **Watch out:** you parse the string array yourself (split each line on spaces → 3 floats).

## My Approach
<!-- your reasoning here -->

## Solution
```python
import sys
# your solution here
```
