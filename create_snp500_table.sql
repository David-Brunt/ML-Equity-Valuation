-- ============================================================
--  PROJECT: S&P 500 DCF Data Warehouse
--  AUTHOR: David Brunt
--  PURPOSE: Store per-company DCF-relevant financial data 
--           (2024–2021) scraped from Yahoo Finance via yfinance.
-- ============================================================

-- Drop any existing version 
drop table if exists public."SNP500_DCF_Variables" cascade;

-- Create the new clean table
create table public."S&P500_DCF_Variables" (
  -- COMPANY-LEVEL METADATA 
  ticker                  text primary key,           -- Stock ticker symbol (unique)
  company_name            text not null,              -- Full company name
  sector                  text not null,              -- Industry sector

  last_updated            timestamptz not null default now(), -- Timestamp of data scrape
  current_price           double precision,           -- Current share price (USD)
  shares_outstanding      double precision,           -- Total shares outstanding
  market_cap              double precision,           -- Market capitalization
  beta                    double precision,           -- Market beta
  tax_rate                double precision,           -- Effective tax rate
  pe_trailing             double precision,           -- Trailing P/E ratio
  pe_forward              double precision,           -- Forward P/E ratio
  p_pcf                   double precision,           -- Price-to-Operating-CF ratio

  
  -- DCF-RELEVANT VARIABLES (Each year’s financial data is grouped together)
  -- ---- 2024 ----
  revenue_2024                double precision not null,
  gross_profit_2024           double precision not null,
  operating_income_2024       double precision not null,
  net_income_2024             double precision not null,
  operating_cash_flow_2024    double precision not null,
  capital_expenditure_2024    double precision not null,
  free_cash_flow_2024         double precision not null,
  total_debt_2024             double precision not null,
  cash_and_equivalents_2024   double precision not null,
  total_equity_2024           double precision not null,
  current_assets_2024         double precision not null,
  current_liabilities_2024    double precision not null,
  gross_margin_2024           double precision not null,
  operating_margin_2024       double precision not null,
  net_margin_2024             double precision not null,
  fcf_margin_2024             double precision not null,
  ofc_margin_2024             double precision not null,
  debt_to_equity_2024         double precision not null,
  current_ratio_2024          double precision not null,
  eps_2024                    double precision not null,

  -- ---- 2023 ----
  revenue_2023                double precision not null,
  gross_profit_2023           double precision not null,
  operating_income_2023       double precision not null,
  net_income_2023             double precision not null,
  operating_cash_flow_2023    double precision not null,
  capital_expenditure_2023    double precision not null,
  free_cash_flow_2023         double precision not null,
  total_debt_2023             double precision not null,
  cash_and_equivalents_2023   double precision not null,
  total_equity_2023           double precision not null,
  current_assets_2023         double precision not null,
  current_liabilities_2023    double precision not null,
  gross_margin_2023           double precision not null,
  operating_margin_2023       double precision not null,
  net_margin_2023             double precision not null,
  fcf_margin_2023             double precision not null,
  ofc_margin_2023             double precision not null,
  debt_to_equity_2023         double precision not null,
  current_ratio_2023          double precision not null,
  eps_2023                    double precision not null,

  -- ---- 2022 ----
  revenue_2022                double precision not null,
  gross_profit_2022           double precision not null,
  operating_income_2022       double precision not null,
  net_income_2022             double precision not null,
  operating_cash_flow_2022    double precision not null,
  capital_expenditure_2022    double precision not null,
  free_cash_flow_2022         double precision not null,
  total_debt_2022             double precision not null,
  cash_and_equivalents_2022   double precision not null,
  total_equity_2022           double precision not null,
  current_assets_2022         double precision not null,
  current_liabilities_2022    double precision not null,
  gross_margin_2022           double precision not null,
  operating_margin_2022       double precision not null,
  net_margin_2022             double precision not null,
  fcf_margin_2022             double precision not null,
  ofc_margin_2022             double precision not null,
  debt_to_equity_2022         double precision not null,
  current_ratio_2022          double precision not null,
  eps_2022                    double precision not null,

  -- ---- 2021 ----
  revenue_2021                double precision not null,
  gross_profit_2021           double precision not null,
  operating_income_2021       double precision not null,
  net_income_2021             double precision not null,
  operating_cash_flow_2021    double precision not null,
  capital_expenditure_2021    double precision not null,
  free_cash_flow_2021         double precision not null,
  total_debt_2021             double precision not null,
  cash_and_equivalents_2021   double precision not null,
  total_equity_2021           double precision not null,
  current_assets_2021         double precision not null,
  current_liabilities_2021    double precision not null,
  gross_margin_2021           double precision not null,
  operating_margin_2021       double precision not null,
  net_margin_2021             double precision not null,
  fcf_margin_2021             double precision not null,
  ofc_margin_2021             double precision not null,
  debt_to_equity_2021         double precision not null,
  current_ratio_2021          double precision not null,
  eps_2021                    double precision not null
);


-- PERFORMANCE OPTIMIZATIONS 
-- Speeds up filtering and grouping by sector
create index if not exists s&p500_sector_idx on public."S&P500_DCF_Variables"(sector);

-- Index by market cap for sorting
create index if not exists s&p500_marketcap_idx on public."S&P500_DCF_Variables"(market_cap);
