-- Databricks notebook source
CREATE CATALOG IF NOT EXISTS formula_dev

-- COMMAND ----------

select current_catalog()

-- COMMAND ----------

USE CATALOG formula_dev

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS bronze
MANAGED LOCATION "abfss://bronze@formula1dlpb.dfs.core.windows.net/"

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS silver
MANAGED LOCATION "abfss://silver@formula1dlpb.dfs.core.windows.net/"

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS gold
MANAGED LOCATION "abfss://gold@formula1dlpb.dfs.core.windows.net/"