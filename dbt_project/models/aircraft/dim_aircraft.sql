WITH FLIGHTCOUNT AS (
    SELECT
        "Aircraft_Id",
        COUNT(*) AS Flight_Count
    FROM raw.public.individual_flights
    GROUP BY "Aircraft_Id"
)
SELECT
    a."Aircraft_Type",
    fc.Flight_Count
FROM raw.public.aircraft a
LEFT JOIN FLIGHTCOUNT fc
    ON a."Aircraft_Id" = fc."Aircraft_Id"
GROUP BY a."Aircraft_Type", fc.Flight_Count
ORDER BY fc.Flight_Count DESC