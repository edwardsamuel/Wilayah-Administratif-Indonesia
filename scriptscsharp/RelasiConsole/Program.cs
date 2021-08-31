using CsvHelper;
using System.Globalization;
using System.Text.Json;

namespace RelasiConsole;

public class Program
{
    static HttpClient httClient = new HttpClient();
    static string csvPath = @"../../../../../csv";

    public static async Task Main(string[] args)
    {
        if (Directory.Exists(csvPath))
        {
            await PostCodeRelation("https://sig-dev.bps.go.id/restBridgingPosController/getwilayah/level/kabupaten/parent/", "postal_code_relation_city_only.csv");
            await PostCodeRelation("https://sig-dev.bps.go.id/restBridgingPosController/getwilayah/level/desa/parent/", "postal_code_relation_city_village.csv");
        }
    }

    private static async Task PostCodeRelation(string link, string fileName)
    {
        IEnumerable<Kota>? daftarKota;
        var daftarKotaResponse = await httClient.GetAsync(link);
        var jsonDataKota = await daftarKotaResponse.Content.ReadAsStringAsync();
        daftarKota = JsonSerializer.Deserialize<IEnumerable<Kota>>(jsonDataKota);
        //filter empty city codes
        daftarKota = daftarKota?.Where(x => !string.IsNullOrEmpty(x.kode_pos));

        if (daftarKota?.Count() > 0)
        {
            using (var writer = new StreamWriter($"{csvPath}/{fileName}"))
            using (var csv = new CsvWriter(writer, CultureInfo.InvariantCulture))
            {
                csv.WriteRecords(daftarKota);
            }
        }
    }
}