# Overview

# Why Should It Be Used
The data access layer, if configured correctly, provides efficient (through caching), universal authentication checks to any component that invokes its functions.

### Page-Level Authentication
Page-level Authentication involves verifying the user session at page mount.

**Advantages:** 
* Really simple to do, and works! 
* The quality of page-level authentication is as good as my verify user session function. If no user session is found, the page is redirected to */login*.  
* The presence of a cookie or **header** based verify user function results in the page or component being dynamically rendered (slower). 
**Disadvantages:** 
* Components on the page such as a grid displaying fetched data from the database are exposed on unprotected pages. 
* *Example:* Let's say I have component `DataGrid` that displays a query from my db. Let's also say my `Admin` page is unprotected. If I nest `DataGrid` in my `Admin` page, the data will be exposed since no redirect occurs.

### Middleware
