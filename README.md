# Customer-Product Retail Analytics Dashboard

## Project Overview
This project showcases a comprehensive Retail Analytics Dashboard created using SQL and Tableau. It demonstrates advanced SQL data modeling, cleaning with Python, and professional dashboard design in Tableau. The analysis focuses on customer demographics and product-level performance using transactional retail data.

## Data Sources
The dataset was sourced from Kaggle and consists of three key CSV files:
- **Customer**: Contains customer demographic details.
- **Transactions**: Contains transactional records, including revenue and quantity.
- **Product**: Contains product category and sub-category mappings.

## Data Cleaning
Python was used to clean the data before loading it into SQL Server:
- **Customer Table**:
  - Converted `DOB` to datetime format.
  - Filled missing `city_code` values with 0 and converted to integer.
- **Transactions Table**:
  - Converted `tran_date` to datetime.
  - Removed duplicate `transaction_id` entries.

## Database and SQL Design
- Created a SQL Server database (`RetailSQLAnalytics`) and `staging` schema to store cleaned tables.
- Used `BULK INSERT` to import data.
- Designed reusable SQL views using CTEs to enable efficient Tableau visualization.
- Ensured all visualizations and KPIs are filterable by common fields (e.g., year, category).

## Dashboard Overview
### Customer Dashboard
- **KPIs**:
  - Total Revenue (with Sparkline)
  - Total Transactions (with Sparkline)
  - Total Quantity (with Sparkline)
- **Visualizations**:
  - Donut Chart: Total Revenue by Age Group
  - Bar Chart: Top 10 Customers by Revenue
  - Line Graph: Monthly Revenue by Gender
- **Filters**: Year, City Code, Product Category, Subcategory, Store Type

### Product Dashboard
- **KPIs**:
  - Total Revenue (with Sparkline)
  - Total Profit (with Sparkline)
  - Total Quantity (with Sparkline)
- **Visualizations**:
  - Line Graph: Monthly Revenue Trend by Product Category
  - Bar Chart: Top 10 Subcategories by Profit
  - Donut Chart: Profit Contribution by Category
- **Filters**: Year, Store Type

### Navigation Feature
A navigation button was added to switch between the two dashboards seamlessly. The final dashboard file is named `customer_product_dashboard.twbx`.

## Insights & Key Findings
- Customers aged **30-50** generate the most revenue.
- **Male** customers consistently bring in more revenue than females.
- **"Men" and "Women"** subcategories are the most profitable.

## Challenges Faced & Learnings
- Designing uniform filters for all visualizations and KPIs in Tableau.
- Ensuring referential integrity across product categories and subcategories.
- Improved skills in writing advanced SQL using CTEs and building interactive dashboards.

## Future Improvements
- Connect Tableau to a live SQL Server database for real-time updates.
- Apply varied and more advanced visual styles for enhanced user experience.
- Add deeper customer segmentation analysis using clustering or RFM models.

## Project Folder Structure
```
├── data/
│   ├── raw/
│   ├── cleaned/
├── scripts/
│   ├── data_cleaning.py
├── sql/
│   ├── 01_create_and_load_db.sql
│   ├── 02_customer_db_view.sql
│   ├── 03_product_db_view.sql
├── dashboards/
│   ├── customer_product_dashboard.twbx
└── README.md
```

---

This project is part of a growing data analytics portfolio demonstrating end-to-end skills from data wrangling to visual storytelling. Contributions, feedback, and collaborations are welcome!

You can explore the interactive Tableau dashboard here:
https://public.tableau.com/views/customer_product_dashboard/CustomerDB?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link
