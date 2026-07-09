# Stock Trader - Bullish Cross
#### Programming Challenge Description:
A classic stock trading pattern happens when a 9-Day Moving Average (9-DMA) crosses the 50-Day Moving Average (50-DMA). This can be indicative of a bullish or bearish setup, depending on the direction.

When the 9-DMA crosses above the 50-DMA from below, it is Bullish. When the 9-DMA cross below the 50-DMA from above, it is Bearish.

Write a program that reads in a series of dates and prices, calculates the 9-DMA and 50-DMA, then returns the dates of any bullish signals that occurred.

**NOTE:** The Moving Average cannot be calculated for a given day if there is not enough historical data to cover the period in question. For example, a series of prices that begin on January 1 cannot have a 9-DMA calculated before January 9 since 9 days of historical prices do not exist until January 9.

### Input:
A series of **Date**|**Price** pairs in non-localized format. Dates will follow ISO 8601 format *YYYY-MM-DD*. Prices will be a two-decimal value with no currency indications.

For example:
```text
2016-01-01|22.05
2016-01-02|22.45
2016-01-03|23.57
```
### Output
A date in ISO 8601 format where a Golden Cross occurred. If no Gold Cross happened, return the string `NULL`


## My approach
From first glance, I knew this question would be a sliding window problem. However, I did not yet know how much complexity the window would need to have.

While trying to knock out the entire problem in one traversal of the input file, I attempted to use a queue to maintain the 9-day and 50-day window. Then, I realized that I couldn't maintain both windows with one queue since popping times are inconsistent. So, I migrated all of the content from the input file to a list to traverse with 3 pointers: `nine_day_pointer`, `fifty_day_pointer` and `i`.


Instead of keeping track of the **Moving Averages,** I kept track of the total sum of 9 and 50 consecutive days to avoid redundant division operations.
```python
nine_day_dma = [0, ]
```
Furthermore, I used a two element array to record the current and previous day's **9 Day Moving Average (9-DMA).** This allows me to tell when the **9-DMA** crosses the **50 Day Moving Average (50-DMA)** from below.
```python
if (nine_day_dma[0] / 9 < fifty_day_dma / 50) and (nine_day_dma[1] / 9 > fifty_day_dma / 50):
	return data_list[0][1].date().isoformat()
```
Adding prices to this element array was very tedious. In order to make the current day the next iteration's previous day, I had to swap elements and replace `nine_day_dma[1]` with  the next *price `(datalist[i][1])`* added to the first element `nine_day_dma[0]`

When the window grew too large **(num of elements) > 9 or > 50,** subtract `data_list[i][1]` from both elements in `nine_day_dma` as well as from `fifty_day_dma` 
## Solution
```python
import sys
# import numpy as np
# import pandas as pd
from datetime import datetime, timedelta
from collections import deque

def solve():
    """Read Date|Price pairs from stdin, print each bullish-cross date (or NULL)."""
    data = sys.stdin.read()
    #print(data)
    data_list = []
    for line in data.split('\n'):
        #print(f"line is {line}")
        split_line = line.split('|')
        date, price = datetime.fromisoformat(split_line[0]), float(split_line[1])
        data_list.append((date, price))

    nine_day_dma = [0, data_list[0][1]]
    fifty_day_dma = data_list[0][1]
    nine_day_pointer = 0
    fifty_day_pointer = 0
    for i in range(1, len(data_list)):
        # nine_day_dma.popleft() =
        diff = abs(data_list[i][0].date() - data_list[i-1][0].date()).days
        if diff != 1:
            nine_day_pointer = i
            fifty_day_pointer = i
            nine_day_dma = [0, data_list[i][1]]
            fifty_day_dma = data_list[i][1]
        nine_day_dma[0], nine_day_dma[1] = nine_day_dma[1], nine_day_dma[0]  # swap elements
        nine_day_dma[1] = nine_day_dma[0] + data_list[i][1]  # update new day
        fifty_day_dma += data_list[i][1]
        if (i - nine_day_pointer) + 1 > 9:
            nine_day_dma[0] -= data_list[nine_day_pointer][1]
            nine_day_dma[1] -= data_list[nine_day_pointer][1]
            nine_day_pointer += 1
        if i - fifty_day_pointer + 1 > 50:
            fifty_day_dma -= data_list[fifty_day_pointer][1]
            fifty_day_pointer += 1
        #if fifty_day_dma
        if (i - nine_day_pointer + 1) >= 9 and (i - fifty_day_pointer + 1) >= 50:
            # print("both windows finished")
            # print(f"50_day_dma = {fifty_day_dma/50}, nine_day_dmas = [{nine_day_dma[0]/9, nine_day_dma[1]/9} at date: {data_list[i][0]}")
            if fifty_day_dma / 50 > nine_day_dma[0] / 9 and fifty_day_dma / 50 < nine_day_dma[1] / 9:
                return data_list[i][0].date().isoformat()

    # first_date, first_price = datetime(line.split('|')[0]), float(line.split('|')[1])
    # if data is None:
    #     return ('NULL')
    # queue = deque([(first_date, first_price)])
    # for line in data:
    #     each line split on `|` for Date(date) + float(price)
    #     OR just record all of the ending days of each month
    #     but then must accommodate leap years
    #     #month_ending = {'01': }
    #     # sliding window for the moving average
    #     if len(queue) == 50:
    #         date, price = datetime(line.split('|')[0]), float(line.split('|')[1])
    #         diff = (date - queue[0][0]).days  # -> timedelta object with days attribute -> integer
    #         if diff != 1:
    #             queue.clear()
    #             nine_day_dma = 0
    #     queue.append((date, price))
    #     # popleft queue when window is greater than 9 days

    nine_day_sum = 0
    # --- your solution here ---
    # 1. parse each line "YYYY-MM-DD|price"
    # 2. compute the 9-DMA and 50-DMA per day
    # 3. find days where 9-DMA crosses from at/below to above the 50-DMA
    # 4. print each cross date on its own line, else print "NULL"
    return("NULL")


# Real-OA entry point (runs when this file is executed as a script with piped stdin).
# The test cell below calls solve() directly with a swapped stdin instead.
if __name__ == "__main__" and not hasattr(sys, "ps1"):
    # Only auto-run under `python practice.py < input.txt`, not inside Jupyter.
    pass
```
### Approach 


