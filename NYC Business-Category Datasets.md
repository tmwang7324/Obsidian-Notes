---
tags: [nyc-commercial-intelligence, datasets, data-sourcing]
created: 2026-07-05
---

# NYC Business-Category Datasets

Sourcing notes for the **nyc-commercial-intelligence** project — datasets that describe NYC businesses by category, to enrich the CDTA (`cdta2020`) feature table beyond the current `act_*_storefront` storefront-registration filings.

Practical filter for this pipeline: **point/address-level, NAICS- or category-tagged, joinable to a CDTA polygon** (same spatial-join pattern already used in `src/feature_engineering.py`).

## Priority: revisit `Restaurant_Licenses.csv` for food storefront features

I already have `Restaurant_Licenses.csv` in the repo root (NYC DOHMH restaurant data, untracked). **Food is the densest storefront category**, so this is the highest-leverage enrichment.

**Goal:** produce food storefront statistics with greater accuracy and more features than the single `act_food_services_storefront` count currently gives.

Plan / ideas:
- Wire ingestion into `src/data_preprocessing.py` (currently a stub) → geocode/spatial-join each record to `cdta2020`, matching the existing pipeline.
- Replace or cross-check the coarse `act_food*` storefront-filing count with a real restaurant establishment count per CDTA.
- Derive richer features from the DOHMH data, e.g.:
  - cuisine-type breakdown per neighborhood (diversity/entropy of cuisines)
  - active vs. closed/inactive establishments (churn signal)
  - inspection grade / score distribution as a quality proxy
  - counts by establishment type (restaurant vs. mobile vs. other)
- Feed the improved food stats back into `build_text_profile` / `_storefront_activity_section` in `src/embeddings.py` so the embedding text reflects real restaurant data, then re-embed (`python -m src.embeddings --force`).

## Direct — establishment-level with explicit category/NAICS

| Source | Category signal | Access | Notes |
|---|---|---|---|
| NYC DCWP Legally Operating Businesses (Open Data) | License category + lat/long | Free | Cleanest direct complement to storefront filings; geocoded → spatial-joins to CDTA. |
| DOHMH Restaurant Inspection Results | Restaurants + cuisine | Free | This is the `Restaurant_Licenses.csv` above — top priority. |
| NYS SLA Liquor Licenses | Bars / restaurants / liquor by license class | Free (NYS Open Data) | Address-level bar/nightlife proxy storefront filings under-capture. |
| Census County/ZIP Business Patterns (CBP/ZBP) | Establishment counts by NAICS | Free | ZIP-level; crosswalk ZIP→CDTA. Good citywide NAICS denominator. |
| LEHD LODES (WAC) | Jobs by NAICS at census-block workplace | Free | Extends existing jobs columns to any NAICS sector; clean CDTA aggregation. |

## Direct — POI datasets (richest category taxonomy)

- **Overture Maps Places** — free, open; `category` + confidence per POI. Best free point-level category source. Strong candidate.
- **OpenStreetMap** (`shop=`, `amenity=`, `office=`) — free, noisy; extract via Overpass/Geofabrik NY.
- **SafeGraph / Advan / Placer.ai / Data Axle (NETS)** — paid; establishment-level NAICS + foot traffic (could also augment `avg_pedestrian` with category-specific visits).
- **Yelp Fusion / Google Places API** — category-tagged; ToS restricts bulk storage → enrichment only, not a redistributable base table.

## Indirect — infer category from land use, permits, spend

- **PLUTO / MapPLUTO** (DCP) — building class codes (retail `K*`, office `O*`, …) + commercial FAR. Commercial-supply denominator; would also let profile text talk about genuine spatial density.
- **DOB permits / Certificates of Occupancy** — occupancy/use-group signals; leading indicator vs. filings.
- **NYS Taxable Sales & Purchases by industry (county)** — dollar demand signal; coarse (county-level).
- **DCWP Sidewalk Café licenses** — narrow street-retail vibrancy proxy.

## Shortlist for this project

1. **DOHMH restaurants** (have the file) + **DCWP Legally Operating Businesses** — free, geocoded, directly extend the `act_*` category vocabulary.
2. **Overture Places** — free point-level coverage across all categories, not just those that file storefront registrations.
3. **PLUTO** — commercial-supply denominator so a category's "share of mix" can normalize against available retail space, not just filing counts.

---

Related: [[index]]
