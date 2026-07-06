CREATE DATABASE IF NOT EXISTS shipping_data_cleaning;
USE shipping_data_cleaning;

CREATE TABLE messy_shipping_data (
shipment_id INT,
container_id VARCHAR(50),
vessel_name VARCHAR(100),
origin_port VARCHAR(100),
destination_port VARCHAR(100),
departure_date VARCHAR(50),
arrival_date VARCHAR(50),
cargo_type VARCHAR(100),
cargo_weight_kg VARCHAR(50),
shipping_cost_usd VARCHAR(50),
shipment_status VARCHAR(50),
customer_name VARCHAR(100)
);

-- 1. Inspect the raw data
select * 
from messy_shipping_data;

-- 2. We will clean the dataset , following the below queries :
    -- 2.1 Text standardization
    -- 2.2 Numeric cleaning
    -- 2.3 Date cleaning
    -- 2.4 Validation checks
    -- 2.5 Dublicates
    
============================================
-- 2.1 Text standarization
============================================

 -- 2.1.1. Vessel Name
 -- Preview
 select vessel_name,
 UPPER(TRIM(vessel_name)) as clean_vessel_name
 from messy_shipping_data;
 
 -- Apply
 update messy_shipping_data
 set vessel_name= UPPER(TRIM(vessel_name));
 
 -- Validate
 select distinct vessel_name
 from messy_shipping_data;

-- 2.1.2 Origin port
-- Preview 
select origin_port ,
UPPER(TRIM(origin_port)) as clean_origin_port
from messy_shipping_data;

-- Apply
update messy_shipping_data
set origin_port = UPPER(TRIM(origin_port));

-- Validate
select distinct origin_port
from messy_shipping_data;

-- 2.1.3 Remaining text columns :
     -- destination_port
     -- cargo type
     -- shipment_status
     -- customer_name
     
-- Preview 
select destination_port,
UPPER(TRIM(destination_port)) as clean_destination_port,
cargo_type,
UPPER(TRIM(cargo_type)) as clean_cargo_type,
shipment_status ,
UPPER(TRIM(shipment_status)) as clean_shipment_status,
customer_name,
UPPER(TRIM(customer_name)) as clean_customer_name
from messy_shipping_data;

-- Apply
update messy_shipping_data
set destination_port  = UPPER(TRIM(destination_port)),
    cargo_type = UPPER(TRIM(cargo_type)),
    shipment_status = UPPER(TRIM(shipment_status)),
    customer_name = UPPER(TRIM(customer_name));

-- Validate
select distinct 
destination_port ,
cargo_type, 
shipment_status,
customer_name
from messy_shipping_data;

==============================
-- 2.2. Numeric cleaning
-- columns : cargo_weight_kg  ,  shipping_cost_usd
==============================

-- 2.2.1 Cargo_weight_kg

-- Preview
select 
cargo_weight_kg,
case 
when cargo_weight_kg is NULL
or TRIM(cargo_weight_kg) = ' '
or LOWER(TRIM(cargo_weight_kg)) = 'unknown'
then NULL
else cast(replace(lower(trim(cargo_weight_kg)),'kg',' ') as decimal(10,2))
end as clean_cargo_weight_kg
from messy_shipping_data;

-- Apply
update messy_shipping_data
set cargo_weight_kg =
case 
when cargo_weight_kg is NULL
or TRIM(cargo_weight_kg) = ''
or LOWER(TRIM(cargo_weight_kg)) = 'unknown'
then NULL
else trim(replace(lower(trim(cargo_weight_kg)),'kg',''))
end;

-- Validate
select distinct cargo_weight_kg
from messy_shipping_data
order by cargo_weight_kg;

-- 2.2.2 Shipping cost USD

-- Preview
select 
shipping_cost_usd,
case
when 
shipping_cost_usd is NULL
or TRIM(shipping_cost_usd)= ''
or LOWER(TRIM(shipping_cost_usd))= 'abc'
then NULL
else TRIM(REPLACE(shipping_cost_usd, '$' , ''))
end as clean_shipping_cost
from messy_shipping_data;

-- Apply
update messy_shipping_data
set shipping_cost_usd = 
case
when shipping_cost_usd is null
or TRIM(shipping_cost_usd) = ''
or LOWER(TRIM(shipping_cost_usd)) = 'abc'
then NULL
else trim(replace(shipping_cost_usd,'$' , ''))
end;

-- Validate
select distinct shipping_cost_usd
from messy_shipping_data;

===========================
-- 2.3 Date cleaning
 -- columns : departure_date , arrival_date
===========================


-- 2.3.1 Departure_date

-- Inspect
select distinct 
arrival_date,
departure_date
from messy_shipping_data;

-- Preview
select 
departure_date,
case 
WHEN departure_date LIKE '____-__-__'
    THEN STR_TO_DATE(departure_date,'%Y-%m-%d')
WHEN departure_date LIKE '___/__/__'
	THEN STR_TO_DATE(departure_date,'%Y/%m/%d')
WHEN departure_date LIKE '__/__/____'
	THEN STR_TO_DATE(departure_date,'%d/%m/%Y')
WHEN departure_date LIKE '__-__-____'
	THEN STR_TO_DATE(departure_date,'%d-%m-%Y')
        ELSE NULL
    END AS clean_departure_date
FROM messy_shipping_data;

-- Apply
update messy_shipping_data
set departure_date =
case
WHEN departure_date LIKE '____-__-__'
    THEN STR_TO_DATE(departure_date,'%Y-%m-%d')
WHEN departure_date LIKE '___/__/__'
	THEN STR_TO_DATE(departure_date,'%Y/%m/%d')
WHEN departure_date LIKE '__/__/____'
	THEN STR_TO_DATE(departure_date,'%d/%m/%Y')
WHEN departure_date LIKE '__-__-____'
	THEN STR_TO_DATE(departure_date,'%d-%m-%Y')
        ELSE NULL
    END ;

-- Validate
select distinct departure_date
from messy_shipping_data
order by departure_date;


-- 2.3.2 Arrival_date

-- Inspect
select distinct 
arrival_date,
departure_date
from messy_shipping_data;

-- Preview
select 
arrival_date,
case 
WHEN arrival_date LIKE '____-__-__'
    THEN STR_TO_DATE(arrival_date,'%Y-%m-%d')
WHEN arrival_date LIKE '___/__/__'
	THEN STR_TO_DATE(arrival_date,'%Y/%m/%d')
WHEN arrival_date LIKE '__/__/____'
	THEN STR_TO_DATE(arrival_date,'%d/%m/%Y')
WHEN arrival_date LIKE '__-__-____'
	THEN STR_TO_DATE(arrival_date,'%d-%m-%Y')
        ELSE NULL
    END AS clean_arrival_date
FROM messy_shipping_data;

-- Apply
update messy_shipping_data
set arrival_date =
case
WHEN arrival_date LIKE '____-__-__'
    THEN STR_TO_DATE(arrival_date,'%Y-%m-%d')
WHEN arrival_date LIKE '___/__/__'
	THEN STR_TO_DATE(arrival_date,'%Y/%m/%d')
WHEN arrival_date LIKE '__/__/____'
	THEN STR_TO_DATE(arrival_date,'%d/%m/%Y')
WHEN arrival_date LIKE '__-__-____'
	THEN STR_TO_DATE(arrival_date,'%d-%m-%Y')
        ELSE NULL
    END ;

-- Validate
select distinct arrival_date
from messy_shipping_data
order by arrival_date;


=========================
-- 2.4 Validation Checks
=========================

select *
from messy_shipping_data;

select distinct shipment_status
from messy_shipping_data;

select distinct cargo_weight_kg
from messy_shipping_data
where cargo_weight_kg like '%kg%' ;

select distinct shipping_cost_usd
from messy_shipping_data
where shipping_cost_usd like '%$%'
or shipping_cost_usd = 'abc' ;

select distinct departure_date
from messy_shipping_data
order by departure_date;

select distinct arrival_date
from messy_shipping_data
order by arrival_date;

=========================
-- 2.5 Dublicate Values
-- Identify dublicate shipments using
-- ROW_NUMBER() nad remove dublicate entries,
-- keeping only the first occurence.
=========================


WITH duplicate_check AS (
select 
shipment_id,
container_id,
ROW_NUMBER() OVER (
PARTITION BY container_id
ORDER BY shipment_id) AS row_num
FROM messy_shipping_data
)
SELECT *
FROM duplicate_check
WHERE row_num > 1;

select * 
from messy_shipping_data
where container_id in (
'MAEU1001179',
'MSCU1000761',
'MSCU1001241',
'MSCU1234567',
'OOLU1001643',
'ZIMU1002286'
)
order by container_id , shipment_id;

-- Dublicate records identified in the previous steo
-- will be removed, while keeping the first occurence
-- of each container_id

DELETE FROM messy_shipping_data
WHERE shipment_id IN (

    SELECT shipment_id
    FROM (

        SELECT
            shipment_id,
            ROW_NUMBER() OVER (
                PARTITION BY container_id
                ORDER BY shipment_id
            ) AS row_num
        FROM messy_shipping_data

    ) AS duplicate_records

    WHERE row_num > 1
);

=============================
select *
from messy_shipping_data;
