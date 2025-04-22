CREATE VIEW staging.vw_CustomerDashboardBase AS

SELECT 
    c.customer_Id,
    c.Gender,
    DATEDIFF(YEAR, c.DOB, GETDATE()) AS customer_age,
    CASE 
        WHEN DATEDIFF(YEAR, c.DOB, GETDATE()) > 50 THEN '50+'
        WHEN DATEDIFF(YEAR, c.DOB, GETDATE()) BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Below 30'
    END AS age_group,
    c.city_code,

    -- Transaction Dimensions
    DATEFROMPARTS(YEAR(t.tran_date), MONTH(t.tran_date), 1) AS transaction_year,
    t.Store_type,
    pc.prod_cat,
    pc.prod_subcat,

    -- Metrics
    COUNT(DISTINCT t.transaction_id) AS total_transactions,
    SUM(CASE WHEN t.total_amt > 0 THEN t.total_amt ELSE 0 END) AS total_revenue,
    SUM(CASE WHEN t.Qty > 0 THEN t.Qty ELSE 0 END) AS total_quantity,
    SUM(CASE WHEN t.total_amt < 0 THEN ABS(t.total_amt) ELSE 0 END) AS total_refund_amount

FROM staging.Customer AS c
JOIN staging.Transactions AS t ON c.customer_Id = t.cust_id
JOIN staging.ProductCategory AS pc 
    ON pc.prod_cat_code = t.prod_cat_code
    AND pc.prod_sub_cat_code = t.prod_sub_cat_code

GROUP BY 
    c.customer_Id,
    c.Gender,
    c.DOB,
    c.city_code,
    DATEFROMPARTS(YEAR(t.tran_date), MONTH(t.tran_date), 1),
    t.Store_type,
    pc.prod_cat,
    pc.prod_subcat;
