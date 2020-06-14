# importing table by table into new database called attvsp_project located in HDFS /user/hive/warehouse
# this database is created automatically in Hive when this Sqoop code is run 
# it is specified with --target-dir keyword

# table: carbon emissions

sqoop import -connect jdbc:mysql://localhost:3306/attvsp_project -password cloudera -username root --as-parquetfile -table carbon_emissions  --target-dir /user/hive/attvsp_project.db --hive-import --create-hive-table  --split-by dt_year  --hive-database attvsp_project --hive-table carbon_emissions

# table: temp_city 

sqoop import -connect jdbc:mysql://localhost:3306/attvsp_project -password cloudera -username root --as-parquetfile -table temp_city  --target-dir /user/hive/attvsp_project.db --hive-import --create-hive-table  --split-by city  --hive-database attvsp_project --hive-table temp_city

# table: temp_country

sqoop import -connect jdbc:mysql://localhost:3306/attvsp_project -password cloudera -username root --as-parquetfile -table temp_country  --target-dir /user/hive/attvsp_project.db --hive-import --create-hive-table  --split-by country  --hive-database attvsp_project --hive-table temp_country

# table: temp global

sqoop import -connect jdbc:mysql://localhost:3306/attvsp_project -password cloudera -username root --as-parquetfile -table temp_global  --target-dir /user/hive/attvsp_project.db --hive-import --create-hive-table  --split-by dt  --hive-database attvsp_project --hive-table temp_global

# table: temp_major_city 

sqoop import -connect jdbc:mysql://localhost:3306/attvsp_project -password cloudera -username root --as-parquetfile -table temp_major_city  --target-dir /user/hive/attvsp_project.db --hive-import --create-hive-table  --split-by city  --hive-database attvsp_project --hive-table temp_major_city

# table: temp_state

sqoop import -connect jdbc:mysql://localhost:3306/attvsp_project -password cloudera -username root --as-parquetfile -table temp_state  --target-dir /user/hive/attvsp_project.db --hive-import --create-hive-table  --split-by state  --hive-database attvsp_project --hive-table temp_state

