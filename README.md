# nc-euro24

This is a study of close-range contacts associated with mass gathering events (MGE) based on mobile phone data.

## Data extraction

The following data extraction scripts query and pre-process a number of aggregation tables from NET CHECK's Crowdsourcing data analysis pipeline as well as imported OpenStreetMap (OSM) data which are all stored in a non-public PostgreSQL database. The pre-processed data are saved in [`data/`](data/) (not included here because too large for Github; will be made available elsewhere).

Data pre-processing scripts:

| script(s) | pre-processing step | saved in |
|-----------|---------------------|----------|
| [`sql/`](sql/) | collect metadata about the GPS panel and mass events | PostgreSQL database |
| [`00_metadata.ipynb`](00_metadata.ipynb) | collect metadata about the GPS panel and mass events | [`data/metadata`](data/metadata) |
| [`01_data.ipynb`](01_data.ipynb) | gather contact data from the GPS panel | [`data/fig1`](data/fig[x]) |

PostgreSQL database tables used in these scripts:

| table | content |
|-------|---------|
| `ex_corona_sdkv6` | raw mobile phone GPS samples |
| `covid_dids_pings_per_day_sdkv6` | aggregated daily counts of device IDs and pings per area and home location; used for stadium visitor counts and city-level ping frequency |
| `covid_network_sdkv6_tl[3,6,7,8]_[10,60]m` | |
| `covid_results_sdkv6` | daily panel data for Germany: number of active device IDs and sample rates per location and day |
| `home_work_sdkv6` | home/work location assignments per device ID; used to count devices with home in Germany |
| `ts_plz_population` | ZIP code to city mapping; used to join device-level home locations to city names |
| `cluster_search_areas_v2` | stadium metadata |
| `planet_osm_polygon` | OpenStreetMap polygon geometries; used to spatially define city boundaries for the home location count |
| `planet_osm_line` | |
| `planet_osm_point` | |
| `tuberlin_euro2024_tileid` | |
| `tuberlin_euro2024_contour` | |
| `tuberlin_euro2024_osm` | |
| `tuberlin_euro2024_osm2` | |
| `tuberlin_euro2024_tile2osmid` | |
| `euro2024_poi_all_smallestpolygon_cities` | |
| `txc_dt_grid_1000m` | |

## Analysis

The following Jupyter notebooks (Python) reproduce the Figures and Tables of the paper. The names of the notebooks are according to which figure they produce the plots and table data of. The plots are saved in pdf and jpg format in [`plots/`](plots/).

| Jupyter notebook | content | saved in |
|------------------|---------|----------|
| [`02_fig1.ipynb`](02_fig1.ipynb) | generate plots of Figure 1 | [`plots/fig1`](plots/fig1) |
| [`03_fig2_figs1.ipynb`](03_fig2_figs1.ipynb) | generate plots of Figures 2 and S1 | [`plots/fig2`](plots/fig2), [`plots/figs1`](plots/figs1) |
| [`04_tabs2_tabs3.ipynb`](04_tabs2_tabs3.ipynb) | generate data of Tables S2 and S3 | — |
| [`05_figs2.ipynb`](05_figs2.ipynb) | generate plots of Figure S2 | [`plots/figs2`](plots/figs2) |
| [`06_figs2_tabs4.ipynb`](06_figs2_tabs4.ipynb) | generate plots of Figure S2 and data of Table S4 | [`plots/figs2`](plots/figs2) |
| [`07_fig3_tabs8.ipynb`](07_fig3_tabs8.ipynb) | generate plots of Figure 3 and data of Table S8 | [`plots/fig3`](plots/fig3) |
| [`08_fig4_tabs9.ipynb`](08_fig4_tabs9.ipynb) | generate plots of Figure 4 and data of Table S9 | [`plots/fig4`](plots/fig4) |
| [`09_fig5_tabs12.ipynb`](09_fig5_tabs12.ipynb) | generate plots of Figure 5 and data of Table S12 | [`plots/fig5`](plots/fig5) |
| [`10_figs3_tabs9.ipynb`](10_figs3_tabs9.ipynb) | generate plots of Figure S3 and data of Table S9 | [`plots/figs3`](plots/figs3) |
| [`11_figs4.ipynb`](11_figs4.ipynb) | generate plots of Figure S4 | [`plots/figs4`](plots/figs4) |
| [`12_fig6.ipynb`](12_fig6.ipynb) | generate plots of Figure 6 | [`plots/fig6`](plots/fig6) |
| [`13_fig6_figs7_tabs10_tabs11.ipynb`](13_fig6_figs7_tabs10_tabs11.ipynb) | generate plots of Figures 6 and S7 and data of Tables S10 and S11 | [`plots/fig6`](plots/fig6), [`plots/figs7`](plots/figs7) |
| [`14_fig7.ipynb`](14_fig7.ipynb) | generate plots of Figure 7 | [`plots/fig7`](plots/fig7) |
