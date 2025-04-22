CREATE VIEW staging.vw_Product_Performance_Insights AS

-- CTE: Prepare cleaned product transactions
WITH ProductSales AS (
    SELECT
        t.transaction_id,
        t.tran_date,
		DATEFROMPARTS(YEAR(t.tran_date), MONTH(t.tran_date), 1) AS transaction_date,
        t.Store_type,
        pc.prod_cat,
        pc.prod_cat_code,
        pc.prod_subcat,
        pc.prod_sub_cat_code,
        t.Qty,
        t.total_amt,
        -- Assuming profit = revenue * 20%
        ROUND(t.total_amt * 0.2, 2) AS profit
    FROM staging.Transactions AS t
    JOIN staging.ProductCategory AS pc
        ON t.prod_cat_code = pc.prod_cat_code
        AND t.prod_sub_cat_code = pc.prod_sub_cat_code
    WHERE t.total_amt > 0  -- exclude returns
)

-- Final SELECT from the CTE
SELECT
    transaction_date,
    Store_type,
    prod_cat,
    prod_cat_code,
    prod_subcat,
    prod_sub_cat_code,
    SUM(Qty) AS total_quantity,
    SUM(total_amt) AS total_revenue,
    SUM(profit) AS total_profit
FROM ProductSales
GROUP BY
    transaction_date,
    Store_type,
    prod_cat,
    prod_cat_code,
    prod_subcat,
    prod_sub_cat_code;

	select *
	from staging.vw_Product_Performance_Insights
