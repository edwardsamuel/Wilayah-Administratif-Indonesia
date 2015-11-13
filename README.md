# Data Provinsi, Kota/Kabupaten, Kecamatan, dan Kelurahan/Desa di Indonesia
Data ini diambil dari situs [Pemutakhiran MFD dan MBS
Badan Pusat Statistik (http://mfdonline.bps.go.id/)](http://mfdonline.bps.go.id/) pada **12 November 2015**.

# Administrative Subdivisions of Indonesia (Provinces, Regencies/Cities, Districts, Villages)
The data were taken from [Central Agency on Statistics (BPS) - MFD and MBS Update (http://mfdonline.bps.go.id/)](http://mfdonline.bps.go.id/) on **12 November 2015**.

The data were `curl`-ed from BPS site:

    curl http://mfdonline.bps.go.id/index.php?link=hasil_pencarian --data "pilihcari=desa&kata_kunci="
    
with `a`, `i`, `u`, `e` and `o` as the keywords.

### Generate new data

In order to generate new data:

    cd scripts
    ./run.sh

*NOTE*: Please create a MySQL database (named: `indonesia`) before run the script. You might need to update MySQL credentials in [`scripts/run.sh`](blob/master/scripts/run.sh).

### License

* The scripts are license under: [MIT](license.md).
* The data (CSV and SQL) are under: [ODBL v1.0](odbl-10.md).
* The source data is attributed to **Badan Pusat Statistik (BPS) Indonesia**.
