# Overview
The built-in `datetime` is module from the standard Python library. It handles days, weeks, hours, minutes, and seconds seamlessly.




## Incrementing by Days and Weeks
To increment a date in Python, add a `datetime.timedelta` **object** to a `datetime.date` **or** `datetime.datetime` **object.**
```python
from datetime import date, timedelta

current_date_str = '2026-07-09'
current_date = datetime.fromisoformat(current_date_str)
new_date = current_date + timedelta(days=5)
print(new_date) # -> 2026-07-14

future_date = current_date + timedelta(weeks=2)
print(future_date) # -> 2026-07-23
```
## Fitting Intervals
To find the amount of time between two dates, use the `timedelta` **object** or subtract objects returned by the `date()` method.
```python
current_date = datetime(2026, 7, 9)
yesterday = datetime(2026, 7, 8)
print((current_date - yesterday) == timedelta(days=1)) # -> True only if current_date and yesterday are exactly, second for second, one day apart

print(abs(current_date.date() - yesterday.date()) == 1) # -> True if the dates differ by 1 day 
```
