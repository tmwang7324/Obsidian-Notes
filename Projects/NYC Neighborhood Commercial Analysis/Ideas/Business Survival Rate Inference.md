# Overview
To forecast the probability that a given business will survive in a neighborhood, I need to transition from static demographic data to **dynamic commercial friction metrics.**

## KPIs
Traditional datasets leave blind spots. To maximize my model's accuracy, incorporate these high-utility predictors:

* **Spatial-Category Saturation Index (SCSI):** Measures the exact ratio of a specific business type (e.g., coffee shops) to the localized daytime population, or demand if data is present. A greater ratio triggers a high failure rate unless *synergy* is present.
* **Anchor Tenant Proximity:** The exact distance to a major foot-traffic driver (e.g., a subway station, a major grocery store, or a popular department store).
* **Category Synergy Coefficient:** The density of *non-competing*, *complementary* businesses. For example, a boutique gym surviving at a higher rate due to its proximity with a health-food cafe.
* **Commercial Rent-to-Income Mismatch (*Uncertain*):** The ratio of average local commercial rent per square foot to the median household income of the surrounding 1-mile radius. High ratios signal an unstable neighborhood cost structure.
* 



### Spatial-Category Saturation Index
Market saturation measures whether the local market can absorb an additional commercial player. It is one of the most determining indicators in a franchise expansion decision, and one of the most rarely calculated with rigor.

#### Ideal Calculation
1. **Estimate Total Market Size:** Number of households in the area multipled by their annual consumption for the relevant proudct category.
2. **Calculate Total Area Occupied by Competitors:** Sum of the areas of similar establishments already present in the area.
3. **Find Median or Average Revenue of a target business:** Using a dataset or numerical operations, get this value.
4. **Amount of Competitor Businesses:** Total Market value divided by median or average revenue of target business.
5. **Determine Revenue per Square Foot in the Area:** Total market size divided by the total area occupied.
6. **Calculate Capturable Market Share for My Area:** Revenue per sqaure foot multipled by the area of my future location.
7. **Evaluate Saturation Level:** Total market size divided by the theoretical absorbale area, compared to the area actually occupied.
8. 


