# sql-hive-and-python
Diving into the world of Hadoop for an uni course


Done for Big Data course in university. Topic of the project is climate change, and it contains data on Earth temperatures on city, country, region and global levels by year, as well as carbon emissions by country and year.

Consists of importing and cleaning data to MySQL, to simulate predefined database. Next step is migrating data from MySQL to Hadoop system (HDFS), where it is saved as Hive database. This is done using Sqoop. Data is further processed using Hive and Impala, until we get it into desired form - able to join temperatures and carbon emissions on country-year composite key. Finally, data is imported to Python using PyHive, and analyzed using numpy, pandas, matplotlib, statsmodels and pmdarima. Forecasting with Holt-Winters Exponential Smoothing and ARIMA model is applied.


### Used Technologies

- Cloudera 5.13 Quickstart Virtual Machine with CentOS 6.7., running on VMPlayer on Ubuntu 18.04
- Apache Sqoop 2
- Apache Hive
- Apache Impala
- Python 3.6 with JupyterLab: pyhive, numpy, pandas, matplotlib, statsmodels, pmdarima
