table "districts" do
	column "id", :key, :as => :integer
	column "regency_id", :integer, :references => "regencies"
	column "name", :string
end

table "provinces" do
	column "id", :key, :as => :integer
	column "name", :string
end

table "regencies" do
	column "id", :key, :as => :integer
	column "province_id", :integer, :references => "provinces"
	column "name", :string
end

table "villages" do
	column "id", :key, :as => :integer
	column "district_id", :integer, :references => "districts"
	column "name", :string
end

