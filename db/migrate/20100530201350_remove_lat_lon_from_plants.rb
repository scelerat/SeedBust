class RemoveLatLonFromPlants < ActiveRecord::Migration
  def self.up
    remove_column :plants, :lat
    remove_column :plants, :lon
  end

  def self.down
    add_column :plants, :lat, :integer
    add_column :plants, :lon, :integer
    Plant.all().each do |plant|
      plant.lat = plant.temp_lat_float.to_int
      plant.lon = plant.temp_lon_float.to_int
      plant.save
    end
  end
end
