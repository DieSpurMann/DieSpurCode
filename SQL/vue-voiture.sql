-- Active: 1708441713397@@localhost@5432@postgres@automotive
set SCHEMA 'Automotive';

select *
from _models
WHERE model_fuel_type = 'Electric';