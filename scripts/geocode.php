<?php 
error_reporting(E_ALL);
ini_set('display_errors', 1);
mysql_connect("localhost","root","");
mysql_select_db("indonesia");
$sql="SELECT * from regencies order BY id ASC LIMIT 500,600 ";
$result=mysql_query($sql);
$i=0;
while($data=mysql_fetch_array($result)){
	$kota=strtolower($data["name"]);
	$kota=str_replace(" ","+",$kota);
	$url="https://maps.googleapis.com/maps/api/geocode/json?address=".$kota."&region=id";
	$file=file_get_contents($url);
	$json=json_decode($file,true);
	$lat=$json["results"][0]["geometry"]["location"]["lat"];
	$lng=$json["results"][0]["geometry"]["location"]["lng"];
	mysql_query("UPDATE regencies SET lat='".$lat."',lng='".$lng."' WHERE id='".$data["id"]."'");
	
}

?>