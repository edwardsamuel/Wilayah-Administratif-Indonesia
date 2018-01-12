table "districts" do
	column "id", :key, :as => :integer, :rename_to => "code"
	column "regency_id", :integer, :references => "regencies", :rename_to => "regency"
	column "name", :string

	before_save do |row|                                    
    	row.code = row.delete('pre_mongified_id')
  	end      
end

table "provinces" do
	column "id", :key, :as => :integer
	column "name", :string
	before_save do |row|                                    
    	row.code = row.delete('pre_mongified_id')
  	end     
end

table "regencies" do
	column "id", :key, :as => :integer, :rename_to => "code"
	column "province_id", :integer, :references => "provinces", :rename_to => "province"
	column "name", :string
	before_save do |row|                                    
    	row.code = row.delete('pre_mongified_id')
  	end        
end

table "villages" do
	column "id", :key, :as => :integer, :rename_to => "code"
	column "district_id", :integer, :references => "districts", :rename_to => "district"
	column "name", :string
	before_save do |row|                                    
    	row.code = row.delete('pre_mongified_id')
  	end       
end
