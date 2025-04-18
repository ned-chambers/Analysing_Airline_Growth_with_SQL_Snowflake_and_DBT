-- What was the best year for growth for each airline?

-- We have ASM and RPM,
-- as well the number of flights Domestic and for some flights International,
-- per Airline and Airport.

-- To list some of the possible ways of evaluate growth, we have:
-- Decrease the difference between ASM - RPM,
-- therefore captivating more passengers out of the ones that they had the capacity for.
-- Increase on ASM, therefore increasing the fleet or the size of the planes, or the number of flights.
-- Increase in number of flights alone.

-- For simplicity and because it seems to be the one providing the best answer,
-- we will use ASM as our growth indicator,
-- and the more ASM an airline has over time, the more we will say they grew.

-- To calculate the growth we will take the AVG(ASM_Domestic) per Airline per Year.

WITH ASM_Per_Year AS (
    SELECT
        "Airline_Code",
        DATE_TRUNC('YEAR', TO_DATE("Date", 'DD/MM/YYYY')) AS Year,
        AVG("ASM_Domestic") AS Avg_ASM_Domestic,
        RANK() OVER (PARTITION BY "Airline_Code" ORDER BY AVG("ASM_Domestic") DESC) AS Rank
    FROM
        {{source('aircraft_data', 'flight_summary_data')}}
    GROUP BY
        "Airline_Code",
        Year
),

Best_ASM_Airline AS (
    SELECT
        "Airline_Code",
        Year,
        Avg_ASM_Domestic AS Max_ASM
    FROM
        ASM_Per_Year
    WHERE
        Rank = 1
    ORDER BY
        "Airline_Code"
)

SELECT
    a.*,
    Best_ASM_Airline.Max_ASM
FROM
    {{source('aircraft_data', 'airlines')}} AS a
LEFT JOIN Best_ASM_Airline
    ON a."Airline_Code" = Best_ASM_Airline."Airline_Code"