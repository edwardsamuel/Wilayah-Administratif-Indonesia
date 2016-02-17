SELECT provinces.id AS Kode, provinces.name AS Provinsi, COUNT(DISTINCT regencies.id) AS "Kabupaten/Kota", COUNT(DISTINCT districts.id) AS "Kecamatan", COUNT(*) AS "Desa/Kelurahan"
FROM
  villages
  INNER JOIN districts ON villages.district_id = districts.id
  INNER JOIN regencies ON districts.regency_id = regencies.id
  INNER JOIN provinces ON regencies.province_id = provinces.id
GROUP BY provinces.id 
ORDER BY provinces.id;