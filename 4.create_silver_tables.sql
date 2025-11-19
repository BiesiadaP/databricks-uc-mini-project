-- Databricks notebook source
DROP TABLE IF EXISTS formula_dev.silver.drivers;

CREATE TABLE IF NOT EXISTS formula_dev.silver.drivers 
AS
SELECT driverId AS driver_id,
      driverRef AS driver_ref,
      number,
      code,
      concat(name.forename, ' ' , name.surname) as name,
      dob,
      nationality,
      current_timestamp() AS ingestion_time
FROM formula_dev.bronze.drivers;

-- COMMAND ----------

DROP TABLE IF EXISTS formula_dev.silver.results;

CREATE TABLE IF NOT EXISTS formula_dev.silver.results
AS
SELECT resultId AS result_id,
      raceId AS race_id,
      driverId AS driver_id,
      constructorId AS constructor_id,
      number,
      grid,
      position,
      positionText,
      positionOrder,
      points,
      laps,
      time,
      milliseconds,
      fastestLap,
      rank,
      fastestLapTime,
      fastestLapSpeed,
      statusId AS status_id,
      current_timestamp() AS ingestion_time
FROM formula_dev.bronze.results;