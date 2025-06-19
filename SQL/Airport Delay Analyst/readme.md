# ✈️ Analisis Keterlambatan Kedatangan Pesawat (SQL Only)

Proyek ini menganalisis data keterlambatan kedatangan pesawat di bandara-bandara Amerika Serikat menggunakan SQL (PostgreSQL). Data berisi lebih dari 100.000 catatan penerbangan dengan berbagai jenis keterlambatan seperti karena cuaca, maskapai, sistem udara nasional, keamanan, dan pesawat sebelumnya.

---

## 📦 Deskripsi Dataset

**Nama Tabel:** `airport_delay`

**Kolom:**

| Nama Kolom              | Keterangan                                 |
|-------------------------|---------------------------------------------|
| year, month, date       | Tanggal penerbangan                         |
| carrier, carrier_name   | Kode dan nama maskapai                      |
| airport, airport_name   | Kode dan nama bandara                       |
| city, state             | Lokasi bandara                              |
| arr_delay               | Total keterlambatan kedatangan (menit)      |
| carrier_delay           | Keterlambatan karena maskapai               |
| weather_delay           | Keterlambatan karena cuaca                  |
| nas_delay               | Keterlambatan karena sistem udara nasional  |
| security_delay          | Keterlambatan karena isu keamanan           |
| late_aircraft_delay     | Keterlambatan karena pesawat sebelumnya     |

---

## ❓ Pertanyaan yang Dijawab dengan SQL

1. Bandara mana dengan rata-rata keterlambatan kedatangan tertinggi?
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

2. Berapa persen kontribusi setiap jenis keterlambatan di tiap bandara?
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

3. Rata-rata keterlambatan per bulan untuk tiap maskapai
SELECT 
    carrier,
    carrier_name,
    month,
    ROUND(AVG(arr_delay), 2) AS avg_arr_delay
FROM airport_delay ad 
GROUP BY carrier, carrier_name, month
ORDER BY carrier, month;

4. Negara bagian dengan keterlambatan terburuk
SELECT 
    state,
    ROUND(AVG(arr_delay), 2) AS avg_arr_delay,
    COUNT(*) AS total_flights
FROM airport_delay ad 
GROUP BY state
HAVING COUNT(*) > 100 -- Filter untuk cukup data
ORDER BY avg_arr_delay DESC
LIMIT 5;

5. Perbandingan delay karena cuaca vs faktor lain
SELECT 
    SUM(weather_delay) AS total_weather_delay,
    SUM(arr_delay - weather_delay) AS total_other_delays,
    ROUND(SUM(weather_delay)*100.0 / NULLIF(SUM(arr_delay), 0), 2) AS weather_delay_pct
FROM airport_delay ad ;

📌 Insight Utama
1.Beberapa maskapai memiliki rata-rata delay tertinggi selama musim panas (Juni–Agustus).

2.Keterlambatan karena cuaca secara umum hanya menyumbang kurang dari 20% dari total keterlambatan.

3.Bandara tertentu konsisten berada di posisi terburuk dalam hal keterlambatan.

4.Negara bagian tertentu memiliki waktu keterlambatan yang jauh di atas rata-rata.
