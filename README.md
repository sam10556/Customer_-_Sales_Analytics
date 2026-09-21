# SQL Data Analytics Project

A hands-on SQL project covering data exploration, analytics, and reporting — following along with the *Data With Baraa* SQL Data Analytics course, adapted and run on **Fedora Linux** using **Docker + VS Code (SQLTools)** instead of Windows/SSMS.

This repo contains SQL scripts organized by analytical theme: database exploration, measures and metrics, time-based trends, cumulative analytics, segmentation, ranking, and customer/product reporting.

## 🧰 Environment

- **OS:** Fedora Linux
- **Database:** SQL Server 2022, running in Docker
- **Editor:** VS Code with the SQLTools extension (SQL Server driver)
- **Data:** Gold-layer flat files (`dim_customers`, `dim_products`, `fact_sales`)

## 📁 Project Structure

```
datasets/
  DataWarehouseAnalytics.bak
  flat-files/
    dim_customers.csv
    dim_products.csv
    fact_sales.csv

scripts/
  00_init_database.sql              → create database, schema, and tables
  01_database_exploration.sql       → explore tables and structure
  02_dimensions_exploration.sql     → explore dimension tables
  03_date_range_exploration.sql     → explore date ranges
  04_measures_exploration.sql       → explore key measures
  05_magnitude_analysis.sql         → magnitude analysis
  06_ranking_analysis.sql           → ranking analysis
  07_change_over_time_analysis.sql  → trends over time
  08_cumulative_analysis.sql        → running totals and cumulative metrics
  09_performance_analysis.sql       → performance analysis
  10_data_segmentation.sql          → data segmentation
  11_part_to_whole_analysis.sql     → part-to-whole analysis
  12_report_customers.sql           → customer report
  13_report_products.sql            → product report

docs/
  Project_Notes_Sketches.pdf
  Project Roadmap.pdf
  Project Roadmap.png
```

## 🚀 Setup

1. Run SQL Server locally in Docker (see `00_init_database.sql` for schema/table setup).
2. Copy the `datasets/flat-files/` CSVs into the container.
3. Run `00_init_database.sql` via `sqlcmd` inside the container to create the database and load the data.
4. Connect to the database from VS Code using SQLTools, and run the numbered scripts in order to follow the analysis roadmap.

## 📊 What's Covered

- Exploring database structure, dimensions, and date ranges
- Key business measures and magnitude analysis
- Ranking and segmentation
- Time-based trends and cumulative (running total) analysis
- Performance analysis (year-over-year, prior period comparisons)
- Customer and product reporting

## 🛡️ License

Licensed under the [MIT License](LICENSE). Original course materials are the property of Data With Baraa.
