-- Active: 1733383437039@@127.0.0.1@5432@mydb

create schema if not exists Automotive;
set schema 'automotive';

--drop table if exists _ cascade;
drop table if exists _Manufacturer cascade;
drop table if exists _Models cascade;

--create table
create table _Manufacturer (
	manufacturer_name varchar(101),
	manufacturer_origin varchar(51),
	constraint manufacturer_pk1 primary key 
	(manufacturer_name, manufacturer_origin)
);

create table _Models (
	manufacturer_name varchar(101),
	model_name varchar(201),
	model_year int,
	model_origin varchar(51),
	model_price money,
	model_body_shape varchar(101),
	model_divisions varchar(101),
	model_type varchar (21),
	model_familly varchar(101),
	isRetro BOOLEAN,
	isRoadLegal BOOLEAN,
	model_fuel_type varchar(101),
	model_engine_type varchar(21),
	model_engine_displacement int,
	model_aspiration varchar(51),
	model_horsepower integer,
	model_torque integer,
	model_drivetrain varchar(6),
	model_gearbox_type varchar(31),
	model_gears smallint,
	model_weight smallint,
	model_top_speed smallint,
	model_0_100 real,
	constraint model_pk1 primary key 
	(manufacturer_name, model_name, model_year),
	constraint model_fk1 foreign key
	(manufacturer_name, model_origin) references _Manufacturer(manufacturer_name, manufacturer_origin)
);

--view
create view American_Cars as
select *
from _Models
where model_origin = 'United States of America'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Aussie_Cars as
select *
from _Models
where model_origin = 'Australia'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view British_Cars as
select *
from _Models
where model_origin = 'United Kingdom'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Chinese_Cars as
select *
from _Models
where model_origin = 'China'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Danish_Cars as
select *
from _Models
where model_origin = 'Denmark'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Dutch_Cars as
select *
from _Models
where model_origin = 'Netherlands'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view French_Cars as
select *
from _Models
where model_origin = 'France'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view German_Cars as
select *
from _Models
where model_origin = 'Germany'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Italian_Cars as
select *
from _Models
where model_origin = 'Italy'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Japanese_Cars as
select *
from _Models
where model_origin = 'Japan'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Spanish_Cars as
select *
from _Models
where model_origin = 'Spain'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Swedish_Cars as
select *
from _Models
where model_origin = 'Sweden'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Top_Speed_Ranking as
select _Models.manufacturer_name, _Models.model_name, _Models.model_year, _Models.model_top_speed
from _Models
order by _Models.model_top_speed DESC, _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Naught_to_100_Ranking as
select _Models.manufacturer_name, _Models.model_name, _Models.model_year, _Models.model_0_100
from _Models
where _Models.model_0_100 >= 0
order by _Models.model_0_100 DESC, _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Price_Ranking as
select _Models.manufacturer_name, _Models.model_name, _Models.model_year, _Models.model_price
from _Models
order by _Models.model_price ASC, _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Power_Output_Ranking as
select _Models.manufacturer_name, _Models.model_name, _Models.model_year, _Models.model_horsepower
from _Models
order by _Models.model_horsepower DESC, _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Torque_Output_Ranking as
select _Models.manufacturer_name, _Models.model_name, _Models.model_year, _Models.model_torque
from _Models
order by _Models.model_torque DESC, _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Minuscule_Liter_Championship as
select *
from _Models
where _Models.model_engine_displacement > 0 AND _Models.model_engine_displacement < 1000
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;
create view One_Liter_Championship as
select *
from _Models
where _Models.model_engine_displacement >= 1000 and _Models.model_engine_displacement < 1500
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;
create view Two_Liter_Championship as
select *
from _Models
where _Models.model_engine_displacement >= 1500 and _Models.model_engine_displacement < 2500
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;
create view Three_Liter_Championship as
select *
from _Models
where _Models.model_engine_displacement >= 2500 and _Models.model_engine_displacement < 3500
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Four_Liter_Championship as
select *
from _Models
where _Models.model_engine_displacement >= 3500 and _Models.model_engine_displacement < 4500
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Five_Liter_Championship as
select *
from _Models
where _Models.model_engine_displacement >= 4500 and _Models.model_engine_displacement < 5500
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Six_Liter_Championship as
select *
from _Models
where _Models.model_engine_displacement >= 5500 and _Models.model_engine_displacement < 6500
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Seven_Liter_Championship as
select *
from _Models
where _Models.model_engine_displacement >= 6500 and _Models.model_engine_displacement < 7500
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Eight_Liter_Championship as
select *
from _Models
where _Models.model_engine_displacement >= 7500 and _Models.model_engine_displacement < 8500
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Nine_Liter_Championship as
select *
from _Models
where _Models.model_engine_displacement >= 8500 and _Models.model_engine_displacement < 9500
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Unnecessary_Liter_Championship as
select *
from _Models
where _Models.model_engine_displacement >= 9500
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Concept_Car_Championship as
select *
from _Models
where _Models.model_type = 'Concept'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Supercar_Championship as
select *
from _Models
where _Models.model_divisions = 'Supercars'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Hypercar_Championship as
select *
from _Models
where _Models.model_divisions = 'Hypercars'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;
create view Sports_Cars_Championship as
select *
from _Models
where _Models.model_divisions = 'Sports Cars'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Diesel_Championship as
select *
from _Models
where _Models.model_fuel_type = 'Diesel'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Petrol_Championship as
select *
from _Models
where _Models.model_fuel_type = 'Petrol'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Hybrid_Championship as
select *
from _Models
where _Models.model_fuel_type = 'Plug-in Hybrid (Petrol)' OR _Models.model_fuel_type = 'Plug-in Hybrid (Diesel)' OR _Models.model_fuel_type = 'Mild Hybrid (Petrol)' OR _Models.model_fuel_type = 'Mild Hybrid (Diesel)' OR _Models.model_fuel_type = 'Full Hybrid (Petrol)' OR _Models.model_fuel_type = 'Full Hybrid (Diesel)'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;
create view Electric_Championship as
select *
from _Models
where _Models.model_fuel_type = 'Electric'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Hydrogen_Championship as
select *
from _Models
where _Models.model_fuel_type = 'Hydrogen'
order by _Models.manufacturer_name, _Models.model_name, _Models.model_year ASC;

create view Lamborghini_V_Ferrari_Showdown as
select *
from _Models
where _Models.manufacturer_name = 'Lamborghini' OR _Models.manufacturer_name = 'Ferrari'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view Resonably_Priced_Cars_Championship as
select *
from _Models
where _Models.model_price <= '10000'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

create view High_Rollers_Championship as
select *
from _Models
where _Models.model_price >= '1000000'
order by _Models.manufacturer_name ASC, _Models.model_name ASC, _Models.model_year ASC;

-- Trigger

CREATE OR REPLACE FUNCTION addManufacturerIfNotExists(
    manufacturer_name_param varchar(101),
    manufacturer_origin_param varchar(51)
)
RETURNS void AS $$
BEGIN
    INSERT INTO _Manufacturer(manufacturer_name, manufacturer_origin)
    SELECT manufacturer_name_param, manufacturer_origin_param
    WHERE NOT EXISTS (
        SELECT 1
        FROM _Manufacturer
        WHERE manufacturer_name = manufacturer_name_param
          AND manufacturer_origin = manufacturer_origin_param
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION addManufacturerTrigger()
RETURNS TRIGGER AS $$
BEGIN
    PERFORM addManufacturerIfNotExists(NEW.manufacturer_name, NEW.model_origin);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER insertManufacturerTrigger
BEFORE INSERT ON _Models
FOR EACH ROW
EXECUTE FUNCTION addManufacturerTrigger();