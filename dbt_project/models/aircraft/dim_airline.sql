-- models/aircraft/dim_airline.sql

-- ⚠️ Note: This model could not be built or tested due to the expiration of the Snowflake free trial.
-- It is included to demonstrate intended data modelling structure and joins.

SELECT
    al."Airline_Code",
    al."Airline_Name",
    rpm.Year AS Best_RPM_Year,
    rpm.Total_RPM AS Best_RPM_Value,
    asm.Year AS Best_ASM_Year,
    asm.Max_ASM AS Best_ASM_Value
FROM {{ source('aircraft_data', 'airlines') }} al
LEFT JOIN {{ ref('int_best_years') }} rpm
    ON al."Airline_Code" = rpm."Airline_Code"
LEFT JOIN {{ ref('int_max_asm_airlines') }} asm
    ON al."Airline_Code" = asm."Airline_Code"