# data_cleaning.py
"""
Data Cleaning Script for Customer and Transactions Tables
Description: This script reads, cleans, and exports the customer and transaction datasets used
in the Retail Sales Analysis project.
"""

import pandas as pd
import numpy as np

# -------------------------------
# 1. Clean Customer Table
# -------------------------------

# Load customer dataset
cust_data = pd.read_csv(r'C:\Users\USER\Downloads\SQL project files\Customer.csv') #replace with your file path

# Convert DOB to datetime format
cust_data['DOB'] = pd.to_datetime(cust_data['DOB'], format="%d-%m-%Y", errors='coerce')

# Replace missing city_code with 0 and convert to integer
cust_data['city_code'] = cust_data['city_code'].fillna(0).astype(int)

# Export cleaned customer data
cust_data.to_csv(r'C:\Users\USER\Downloads\SQL project files\Customer_Cleaned.csv', index=False) #replace with your file path
print("✅ Customer data cleaned and saved.")

# -------------------------------
# 2. Clean Transactions Table
# -------------------------------

# Load transactions dataset
tran_data = pd.read_csv(r'C:\Users\USER\Downloads\SQL project files\Transactions.csv') #replace with your file path

# Convert transaction date to datetime
tran_data['tran_date'] = pd.to_datetime(tran_data['tran_date'], format="%d-%m-%Y", errors='coerce')

# Identify duplicate transaction IDs
duplicates = tran_data[tran_data.duplicated(subset="transaction_id", keep=False)]
print("🔍 Duplicate transactions found:")
print(duplicates)

# Drop duplicates, keeping the first occurrence
tran_data_cleaned = tran_data.drop_duplicates(subset="transaction_id", keep="first")

# Export cleaned transaction data
tran_data_cleaned.to_csv(r'C:\BulkData\Clean_Transactions.csv', index=False) #replace with your file path
print("✅ Transaction data cleaned and saved.")
