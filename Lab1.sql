-- 1. Write a SQL statement to create a simple table countries including columns country_id,country_name and region_id.

CREATE TABLE countries (
  country_id VARCHAR(2),
  country_name VARCHAR(50) ,
  region_id INT);
  
-- 2. Write a SQL statement to create the structure of a table dup_countries similar to countries.

CREATE TABLE dup_countries LIKE countries;

-- 3. Write a SQL statement to create a table countries set a constraint NOT NULL.

ALTER TABLE countries 
MODIFY country_id CHAR(2) NOT NULL;

ALTER TABLE countries
MODIFY country_name VARCHAR(50) NOT NULL;

ALTER TABLE countries
MODIFY region_id INT NOT NULL;

 
-- 4. Write a SQL statement to insert a record with your own value into the table countries against each columns.

INSERT INTO countries VALUES ('SE','Sweden',01);

-- 5. Write a SQL statement to insert 3 rows by a single insert statement.

INSERT INTO countries VALUES
('DK','Denmark',01),
('NO','Norway',01),
('FI','Finland',01),
('EE','Estonia',02);

-- 6. Write a SQL statement to insert a record into the table countries to ensure that, a country_id and region_id combination will be entered once in the table

ALTER TABLE countries ADD CONSTRAINT UC_countries UNIQUE(country_id, region_id);

INSERT IGNORE INTO countries VALUES 
('EE','Estonia',02),
('LV','Latvia',02),
('LT','Lithuania',02);

-- Sync dup_coutries table with the changes done in countries table
DROP TABLE dup_countries;
CREATE TABLE dup_countries LIKE countries;
INSERT INTO dup_countries SELECT * FROM countries;

-- select the data from both the tables

SELECT * FROM countries;
SELECT * FROM dup_countries;