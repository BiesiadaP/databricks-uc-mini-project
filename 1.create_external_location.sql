-- Databricks notebook source
CREATE EXTERNAL LOCATION formula1dlpb_bronze
  URL 'abfss://bronze@formula1dlpb.dfs.core.windows.net/'
  WITH (STORAGE CREDENTIAL `d598c6e7-cd16-4d04-8b3a-a14c3fba6e57-storage-credential-1762618491779`);

-- COMMAND ----------

-- MAGIC %fs
-- MAGIC ls 'abfss://bronze@formula1dlpb.dfs.core.windows.net/'

-- COMMAND ----------

CREATE EXTERNAL LOCATION formula1dlpb_silver
  URL 'abfss://silver@formula1dlpb.dfs.core.windows.net/'
  WITH (STORAGE CREDENTIAL `d598c6e7-cd16-4d04-8b3a-a14c3fba6e57-storage-credential-1762618491779`);

-- COMMAND ----------

CREATE EXTERNAL LOCATION formula1dlpb_gold
  URL 'abfss://gold@formula1dlpb.dfs.core.windows.net/'
  WITH (STORAGE CREDENTIAL `d598c6e7-cd16-4d04-8b3a-a14c3fba6e57-storage-credential-1762618491779`);