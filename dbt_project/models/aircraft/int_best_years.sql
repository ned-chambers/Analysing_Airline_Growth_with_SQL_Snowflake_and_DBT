-- What was the best year for Revenue Passenger-Miles for each airline?

-- The fields that track international values have frequent null values.
-- We will consider them as zeros for simplicity but that must be accounted for
-- before doing any kind of analysis because that will bias the results.

-- Process Calculate the SUM of all RPM (Domestic, International or both at the same time, so, Total),
-- and then select the MAX per airline, which will yield us the year as well.
-- By selecting a specific type of RPM or both we will obtain different answers, therefore all three must be provided.

WITH RPM_Summary AS (
    SELECT
        "Airline_Code",
        DATE_TRUNC('YEAR', TO_DATE("Date", 'DD/MM/YYYY')) AS Year,
        SUM(COALESCE("RPM_Domestic", 0)) AS Total_RPM_Domestic,
        SUM(COALESCE("RPM_International", 0)) AS Total_RPM_International,
        SUM(COALESCE("RPM_Domestic", 0)) + SUM(COALESCE("RPM_International", 0)) AS Total_RPM
    FROM {{source ('aircraft_data', 'flight_summary_data')}}
    GROUP BY "Airline_Code", Year
),

Ranked_RPM AS (
    SELECT
        "Airline_Code",
        Year,
        Total_RPM_Domestic,
        Total_RPM_International,
        Total_RPM,
        RANK() OVER (PARTITION BY "Airline_Code" ORDER BY Total_RPM_Domestic) AS Rank_Domestic,
        RANK() OVER (PARTITION BY "Airline_Code" ORDER BY Total_RPM_International) AS Rank_International,
        RANK() OVER (PARTITION BY "Airline_Code" ORDER BY Total_RPM) AS Rank_Total
        FROM
            RPM_Summary
),

best_years AS (
    SELECT
        "Airline_Code",
        Year,
        Total_RPM_Domestic,
        Total_RPM_International,
        Total_RPM
    FROM
        Ranked_RPM
    WHERE
        Rank_Domestic = 1
        OR Rank_International = 1
        OR Rank_Total = 1
)

SELECT
    a.*,
    b.Year,
    b.Total_RPM
FROM {{source ('aircraft_data', 'airlines')}} AS a
LEFT JOIN best_years AS b
    ON a."Airline_Code" = b."Airline_Code"