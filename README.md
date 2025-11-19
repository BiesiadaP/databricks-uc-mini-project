# databricks-uc-mini-project

🏁 Databricks F1 Data Processing Pipeline with Unity Catalog

This project implements a Medallion Architecture (Bronze, Silver, Gold layers) on Databricks, leveraging Unity Catalog for centralized governance and Azure Data Lake Storage (ADLS) Gen2 for external data storage. The pipeline processes raw Formula 1 data files and is orchestrated using a Databricks Workflow.

1. ⚙️ Initial Setup: External Locations and Catalog Creation

The first steps involve establishing the foundational infrastructure:

    Creating External Locations (1.create_external_location.sql): This script sets up three named External Locations (formula1dlpb_bronze, formula1dlpb_silver, formula1dlpb_gold) pointing to specific container paths (abfss://bronze@..., abfss://silver@..., abfss://gold@...) within the ADLS Gen2 storage account. These locations map the logical storage layers to physical storage using a configured Storage Credential.

            Creating the Catalog and Schemas (2.create_catalog_schemas.sql):

        A Unity Catalog named formula_dev is created.

        The notebook switches to use this new catalog (USE CATALOG formula_dev).

        Three schemas (databases) are created within this catalog, aligning with the Medallion Architecture:

            bronze: Managed Location points to the ADLS /bronze path.

            silver: Managed Location points to the ADLS /silver path.

            gold: Managed Location points to the ADLS /gold path.

2. 🥉 Bronze Layer: Ingesting Raw Data

    Script (3.create_bronze_tables.sql): This script defines the structure for raw data tables.

        It creates two external tables in the formula_dev.bronze schema: drivers and results.

        The tables use the json format.

        They are explicitly linked to raw JSON files stored in the ADLS /bronze path (path 'abfss://bronze@formula1dlpb.dfs.core.windows.net/drivers.json' and results.json).

        The schema for the drivers table includes a STRUCT type for the driver's name (name STRUCT<forename: STRING, surname: STRING>), reflecting the semi-structured nature of the raw JSON data.

3. 🥈 Silver Layer: Cleaning and Transformation

    Script (4.create_silver_tables.sql): This script transforms the raw Bronze data, cleans it, and moves it to the Silver layer.

        It creates two new tables in the formula_dev.silver schema: drivers and results using CTAS (CREATE TABLE AS SELECT) statements.

        Transformations applied:

            Standardization: Column names are standardized (e.g., driverId becomes driver_id).

            Data Structuring/Flattening: For the drivers table, the nested name struct is flattened and concatenated into a single name column: concat(name.forename, ' ' , name.surname) as name.

            Auditability: An ingestion_time column is added to both tables using current_timestamp().

4. 🏆 Gold Layer: Business Aggregations

    Script (5.create_gold_tables.sql): The Gold layer focuses on deriving business-specific metrics.

        It creates a final table: formula_dev.gold.driver_wins.

        This table is populated by:

            Joining the cleaned formula_dev.silver.drivers table with the formula_dev.silver.results table on driver_id.

            Filtering the results where the position is 1 (indicating a win).

            Grouping the results by the driver's name and counting the number of wins (count(1) AS numbers_of_wins).

5. 🔁 Workflow Orchestration

    File (yaml_workflow.yaml): A YAML file defines a Databricks Job Workflow named wf_process_f1_data to ensure the notebooks run in the correct sequence.

        Tasks and Dependencies:

            Create_Bronze_Tables (runs 3.create_bronze_tables.sql)

            Create_Silver_Tables (runs 4.create_silver_tables.sql), depends on Create_Bronze_Tables.

            Create_Gold_Tables (runs 5.create_gold_tables.sql), depends on Create_Silver_Tables.

        This setup guarantees that raw tables are defined before transformations occur, and transformations are complete before final aggregation.
