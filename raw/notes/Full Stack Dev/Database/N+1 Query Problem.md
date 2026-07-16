# Overview
The chief symptom of this problem is that there are many, many queries being performed. 

**NESTED QUERIES:** Typically, this happens when you structure your code so that you first do a query to get a list of records, then subsequently do another query for each of those records.

# Solutions
**USING JOINS:** If I want to query every row of