# Data Provinsi, Kota/Kabupaten, Kecamatan, dan Kelurahan/Desa di Indonesia
Data ini diambil dari situs [Pemutakhiran MFD dan MBS
Badan Pusat Statistik (http://mfdonline.bps.go.id/)](http://mfdonline.bps.go.id/) pada **17 Februari 2016**.

# Administrative Subdivisions of Indonesia (Provinces, Regencies/Cities, Districts, Villages)
The data were taken from [Central Agency on Statistics (BPS) - MFD and MBS Update (http://mfdonline.bps.go.id/)](http://mfdonline.bps.go.id/) on **17 February 2016**.

The data were `curl`-ed from BPS site:

    curl http://mfdonline.bps.go.id/index.php?link=hasil_pencarian --data "pilihcari=desa&kata_kunci="
    
with `a`, `i`, `u`, `e` and `o` as the keywords.

**WARNING**: This version of data contains **duplicate** village codes, such as `7402062009` for `DANA TIMUR` and `WALI` in WATOPUTE, KABUPATEN MUNA, SULAWESI TENGGARA. The MySQL version uses `INSERT IGNORE` statements and skips the duplicate items.

## Statistics

```
+------+---------------------------+----------------+-----------+
| Kode | Provinsi                  | Kabupaten/Kota | Kecamatan |
+------+---------------------------+----------------+-----------+
| 11   | ACEH                      |             23 |       289 |
| 12   | SUMATERA UTARA            |             33 |       440 |
| 13   | SUMATERA BARAT            |             19 |       179 |
| 14   | RIAU                      |             12 |       166 |
| 15   | JAMBI                     |             11 |       138 |
| 16   | SUMATERA SELATAN          |             17 |       232 |
| 17   | BENGKULU                  |             10 |       129 |
| 18   | LAMPUNG                   |             15 |       227 |
| 19   | KEPULAUAN BANGKA BELITUNG |              7 |        47 |
| 21   | KEPULAUAN RIAU            |              7 |        66 |
| 31   | DKI JAKARTA               |              6 |        44 |
| 32   | JAWA BARAT                |             27 |       626 |
| 33   | JAWA TENGAH               |             35 |       573 |
| 34   | DI YOGYAKARTA             |              5 |        78 |
| 35   | JAWA TIMUR                |             38 |       664 |
| 36   | BANTEN                    |              8 |       155 |
| 51   | BALI                      |              9 |        57 |
| 52   | NUSA TENGGARA BARAT       |             10 |       116 |
| 53   | NUSA TENGGARA TIMUR       |             22 |       306 |
| 61   | KALIMANTAN BARAT          |             14 |       174 |
| 62   | KALIMANTAN TENGAH         |             14 |       136 |
| 63   | KALIMANTAN SELATAN        |             13 |       152 |
| 64   | KALIMANTAN TIMUR          |             10 |       103 |
| 65   | KALIMANTAN UTARA          |              5 |        50 |
| 71   | SULAWESI UTARA            |             15 |       168 |
| 72   | SULAWESI TENGAH           |             13 |       175 |
| 73   | SULAWESI SELATAN          |             24 |       306 |
| 74   | SULAWESI TENGGARA         |             17 |       216 |
| 75   | GORONTALO                 |              6 |        77 |
| 76   | SULAWESI BARAT            |              6 |        69 |
| 81   | MALUKU                    |             11 |       118 |
| 82   | MALUKU UTARA              |             10 |       115 |
| 91   | PAPUA BARAT               |             13 |       181 |
| 94   | PAPUA                     |             29 |       499 |
+------+---------------------------+----------------+-----------+
```

## Generate new data

In order to generate new data:

    cd scripts
    pip install -r requirements.txt
    ./run.sh

## License

* The scripts are license under: [MIT](license.md).
* The data (CSV and SQL) are under: [ODBL v1.0](odbl-10.md).
* The source data is attributed to **Badan Pusat Statistik (BPS) Indonesia**.

## Contributing

1. Fork it (https://github.com/edwardsamuel/Wilayah-Administratif-Indonesia/fork).
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create a new Pull Request.