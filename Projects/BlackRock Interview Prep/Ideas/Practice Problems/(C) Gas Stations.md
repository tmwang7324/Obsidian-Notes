# (C) Gas Stations (Road Trip)

> BlackRock OA problem — 小红书 report ("最新通过 BlackRock OA 两题", Q1). Source embedded below.

#### Programming Challenge Description:
You've decided to make a road trip across the country in a straight line. You have chosen
the direction you'd like to travel and made a list of cities in that direction that have
gas stations to stop at and fill up your tank. To make sure that this route is viable, you
need to know the distances between the adjacent cities in order to be able to travel this
distance on a single tank of gasoline (no one likes running out of gas), but you only know
distances to each city from your starting point.

### Input:
Your program should read lines from standard input. Each line contains the list of cities
and distances to them, comma delimited, from the starting point of your trip. You start
your trip at point 0. The cities with their distances are separated by a semicolon.

Example: `Rkbs,5453; Wdqiz,1245; ...`

### Output:
Print out the distances between adjacent cities (the gaps), comma separated.

Example expected output: `245,58,2587,1563,136`

![[最新通过BlackRock OA 两题_1_bug克星_来自小红书网页版.jpg]]

## Pattern / Hint
- **Pattern:** parse `City,distance` pairs, order by distance from start, then take
  **consecutive differences**.
- **Watch out:** the input pairs may not be given in ascending distance order — sort by
  distance first. Split each line on `;`, then each pair on `,`. (Screenshot is partially
  occluded — confirm exact output ordering when solving.)

## My Approach
<!-- your reasoning here -->

## Solution
```python
import sys
# your solution here
```
