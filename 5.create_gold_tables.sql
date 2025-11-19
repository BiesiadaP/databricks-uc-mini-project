-- Databricks notebook source
DROP TABLE IF EXISTS formula_dev.gold.driver_wins;

CREATE TABLE formula_dev.gold.driver_wins
AS
SELECT d.name, count(1) AS numbers_of_wins 
  FROM formula_dev.silver.drivers d
  JOIN formula_dev.silver.results r ON d.driver_id = r.driver_id
WHERE r.position = 1
GROUP BY d.name;