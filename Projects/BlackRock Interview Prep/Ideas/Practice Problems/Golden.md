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


