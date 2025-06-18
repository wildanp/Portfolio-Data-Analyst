-- Total dan Rata-rata Delay Berdasarkan Bandara
SELECT 
    airport,
    airport_name,
    COUNT(*) AS total_flights,
    SUM(arr_delay) AS total_arr_delay,
    ROUND(AVG(arr_delay), 2) AS avg_arr_delay
FROM airport_delay ad 
GROUP BY airport, airport_name
ORDER BY avg_arr_delay DESC
LIMIT 10;

--Presentase Kontribusi Jenis Delay
SELECT 
    airport,
    airport_name,
    ROUND(SUM(carrier_delay) * 100.0 / NULLIF(SUM(arr_delay), 0), 2) AS carrier_delay_pct,
    ROUND(SUM(weather_delay) * 100.0 / NULLIF(SUM(arr_delay), 0), 2) AS weather_delay_pct,
    ROUND(SUM(nas_delay) * 100.0 / NULLIF(SUM(arr_delay), 0), 2) AS nas_delay_pct,
    ROUND(SUM(security_delay) * 100.0 / NULLIF(SUM(arr_delay), 0), 2) AS security_delay_pct,
    ROUND(SUM(late_aircraft_delay) * 100.0 / NULLIF(SUM(arr_delay), 0), 2) AS late_aircraft_delay_pct
FROM airport_delay ad 
GROUP BY airport, airport_name
ORDER BY late_aircraft_delay_pct DESC
LIMIT 10;

--Delay rata-rata per maskapai per bulan
SELECT 
    carrier,
    carrier_name,
    month,
    ROUND(AVG(arr_delay), 2) AS avg_arr_delay
FROM airport_delay ad 
GROUP BY carrier, carrier_name, month
ORDER BY carrier, month;

--Top 5 negara bagian dengan nilai terburuk
SELECT 
    state,
    ROUND(AVG(arr_delay), 2) AS avg_arr_delay,
    COUNT(*) AS total_flights
FROM airport_delay ad 
GROUP BY state
HAVING COUNT(*) > 100 -- Filter untuk cukup data
ORDER BY avg_arr_delay DESC
LIMIT 5;

--Proprsi delay karena cuaca vs faktor lain
SELECT 
    SUM(weather_delay) AS total_weather_delay,
    SUM(arr_delay - weather_delay) AS total_other_delays,
    ROUND(SUM(weather_delay)*100.0 / NULLIF(SUM(arr_delay), 0), 2) AS weather_delay_pct
FROM airport_delay ad ;



