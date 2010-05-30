class AddLatLonFloatFieldsToPlants < ActiveRecord::Migration
  def self.up
    add_column :plants, :lat, :float
    add_column :plants, :lon, :float
    Plant.all().each do |plant|
      plant.lat = plant.temp_lat_float
      plant.lon = plant.temp_lon_float
      plant.save
    end
  end

  def self.down
    remove_column :plants, :lat
    remove_column :plants, :lon
  end
end
