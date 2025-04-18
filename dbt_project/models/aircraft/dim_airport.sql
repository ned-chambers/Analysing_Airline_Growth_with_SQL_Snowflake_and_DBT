WITH subquery AS (
    SELECT
        "Departure_Airport_Code",
        "Aircraft_Id",
        COUNT(*) AS Total_Flights
    FROM {{source('aircraft_data', 'individual_flights')}}
    GROUP BY "Departure_Airport_Code", "Aircraft_Id"
),

passenger_count AS (
    SELECT
        a."Airport_Code",
        SUM(sub.Total_Flights * cr."Capacity") AS Total_Passengers
    FROM subquery sub
    JOIN {{source('aircraft_data', 'aircraft')}} AS cr
        ON sub."Aircraft_Id" = cr."Aircraft_Id"
    JOIN {{source('aircraft_data', 'airports')}} AS a
        ON sub."Departure_Airport_Code" = a."Airport_Code"
    GROUP BY a."Airport_Code"
)

SELECT
    a.*,
    pc.Total_Passengers
FROM {{source('aircraft_data', 'airports')}} AS a
LEFT JOIN passenger_count pc
    ON a."Airport_Code" = pc."Airport_Code"
ORDER BY pc.Total_Passengers DESC