-- SQL code to load all tables into MySQL


-- Creating database

CREATE DATABASE attvsp_project;

USE attvsp_project;


-- Carbon emissions table

CREATE TABLE carbon_emissions (
	dt_year int,
	country varchar (255),
	total float (12,2),
	solid_fuel float (12,2),
	liquid_fuel float (12,2),
	gas_fuel float (12,2),
	cement float (12,2),
	gas_flaring float (12,2),
	per_capita float (12,2),
	bunker_fuels float (12,2));	

LOAD DATA INFILE '/home/cloudera/Desktop/ATTVSP project/data/carbon_emissions.csv' 
INTO TABLE carbon_emissions
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- cleaning countries 
-- manually ensuring consistence between most countries (at least bigger and more significant ones)
-- so their names can be used as joining key
-- updating country names in carbon_emissions to be like those in temperatures dataset

UPDATE carbon_emissions SET country = 'ANTIGUA AND BARBUDA' WHERE country = 'ANTIGUA & BARBUDA';
UPDATE carbon_emissions SET country = 'BOSNIA AND HERZEGOVINA' WHERE country = 'BOSNIA & HERZEGOVINA';
UPDATE carbon_emissions SET country = 'CHINA' WHERE country = 'CHINA (MAINLAND)';
UPDATE carbon_emissions SET country = 'CONGO (DEMOCRATIC REPUBLIC OF THE)' WHERE country =  'DEMOCRATIC REPUBLIC OF THE CONGO (FORMERLY ZAIRE)';
UPDATE carbon_emissions SET country = 'VIETNAM' WHERE country = 'DEMOCRATIC REPUBLIC OF VIETNAM';
UPDATE carbon_emissions SET country = 'FRANCE' WHERE country = 'FRANCE (INCLUDING MONACO)';
UPDATE carbon_emissions SET country = 'HONG KONG' WHERE country = 'HONG KONG SPECIAL ADMINSTRATIVE REGION OF CHINA';
UPDATE carbon_emissions SET country = 'ITALY' WHERE country = 'ITALY (INCLUDING SAN MARINO)';
UPDATE carbon_emissions SET country = 'IRAN' WHERE country = 'ISLAMIC REPUBLIC OF IRAN';
UPDATE carbon_emissions SET country = 'LIBYA' WHERE country = 'LIBYAN ARAB JAMAHIRIYAH';
UPDATE carbon_emissions SET country = 'BURMA' WHERE country = 'MYANMAR (FORMERLY BURMA)';
UPDATE carbon_emissions SET country = 'BOLIVIA' WHERE country = 'PLURINATIONAL STATE OF BOLIVIA';
UPDATE carbon_emissions SET country = 'CAMEROON' WHERE country = 'REPUBLIC OF CAMEROON';
UPDATE carbon_emissions SET country = 'RUSSIA' WHERE country = 'RUSSIAN FEDERATION';
UPDATE carbon_emissions SET country = 'UNITED STATES' WHERE country = 'UNITED STATES OF AMERICA';
UPDATE carbon_emissions SET country = 'SYRIA' WHERE country = 'SYRIAN ARAB REPUBLIC';


-- Global Land Temeperatures by City table

CREATE TABLE temp_city (
	dt varchar (10),
	avg_temp float (10,3),
	avg_temp_uncertainty float (10,3),
	city varchar(255),
	country varchar (255),
	latitude varchar (10),
	longitude varchar (10));

LOAD DATA INFILE '/home/cloudera/Desktop/ATTVSP project/data/GlobalLandTemperaturesByCity.csv' 
INTO TABLE temp_city
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(dt, @vavg_temp, @vavg_temp_uncertainty, city, country, latitude, longitude)
SET
avg_temp = NULLIF(@vavg_temp, ''),
avg_temp_uncertainty = NULLIF(@vavg_temp_uncertainty, '');

UPDATE temp_city SET city = REPLACE(city, '\r', '');
UPDATE temp_city SET country = REPLACE(country, '\r', '');


-- Global Land Temeperatures by Country table

CREATE TABLE temp_country (
	dt varchar (10),
	avg_temp float (10,3),
	avg_temp_uncertainty float (10,3),
	country varchar (255));

LOAD DATA INFILE '/home/cloudera/Desktop/ATTVSP project/data/GlobalLandTemperaturesByCountry.csv' 
INTO TABLE temp_country
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(dt, @vavg_temp, @vavg_temp_uncertainty, country)
SET
avg_temp = NULLIF(@vavg_temp, ''),
avg_temp_uncertainty = NULLIF(@vavg_temp_uncertainty, '');

UPDATE temp_country SET country = REPLACE(country, '\r', '');

-- Global Land Temeperatures by Major City table

CREATE TABLE temp_major_city (
	dt varchar (10),
	avg_temp float (10,3),
	avg_temp_uncertainty float (10,3),
	city varchar(255),
	country varchar (255),
	latitude varchar (10),
	longitude varchar (10));

LOAD DATA INFILE '/home/cloudera/Desktop/ATTVSP project/data/GlobalLandTemperaturesByMajorCity.csv' 
INTO TABLE temp_major_city
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(dt, @vavg_temp, @vavg_temp_uncertainty, city, country, latitude, longitude)
SET
avg_temp = NULLIF(@vavg_temp, ''),
avg_temp_uncertainty = NULLIF(@vavg_temp_uncertainty, '');

UPDATE temp_major_city SET city = REPLACE(city, '\r', '');
UPDATE temp_major_city SET country = REPLACE(country, '\r', '');


-- Global Land Temperatures by State table

CREATE TABLE temp_state (
	dt varchar (10),
	avg_temp float (10,3),
	avg_temp_uncertainty float (10,3),
	state varchar (255),
	country varchar (255));

LOAD DATA INFILE '/home/cloudera/Desktop/ATTVSP project/data/GlobalLandTemperaturesByState.csv' 
INTO TABLE temp_state
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(dt, @vavg_temp, @vavg_temp_uncertainty, state, country)
SET
avg_temp = NULLIF(@vavg_temp, ''),
avg_temp_uncertainty = NULLIF(@vavg_temp_uncertainty, '');

UPDATE temp_state SET state = REPLACE(state, '\r', '');
UPDATE temp_state SET country = REPLACE(country, '\r', '');


-- Global Temperatures table 

CREATE TABLE temp_global (
	dt varchar (10),
	land_avg_temp float (10,3),
	land_avg_temp_uncertainty float (10,3),
	land_max_temp float (10,3),
	land_max_temp_uncertainty float (10,3),
	land_min_temp float (10,3),
	land_min_temp_uncertainty float (10,3),
	land_ocean_avg_temp float (10,3),
	land_ocean_avg_temp_uncertainty float (10,3));

LOAD DATA INFILE '/home/cloudera/Desktop/ATTVSP project/data/GlobalTemperatures.csv' 
INTO TABLE temp_global
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(dt, @vland_avg_temp, @vland_avg_temp_uncertainty, @vland_max_temp, @vland_max_temp_uncertainty,
@vland_min_temp, @vland_min_temp_uncertainty, @vland_ocean_avg_temp, @vland_ocean_avg_temp_uncertainty)
SET
land_avg_temp = NULLIF(@vland_avg_temp, ''),
land_avg_temp_uncertainty = NULLIF(@vland_avg_temp_uncertainty, ''),
land_max_temp = NULLIF(@vland_max_temp, ''),
land_max_temp_uncertainty = NULLIF(@vland_max_temp_uncertainty, ''),
land_min_temp = NULLIF(@vland_min_temp, ''),
land_min_temp_uncertainty = NULLIF(@vland_min_temp_uncertainty, ''),
land_ocean_avg_temp = NULLIF(@vland_ocean_avg_temp, ''),
land_ocean_avg_temp_uncertainty = NULLIF(@vland_ocean_avg_temp_uncertainty, '');
