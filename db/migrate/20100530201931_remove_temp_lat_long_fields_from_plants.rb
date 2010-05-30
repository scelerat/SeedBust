class RemoveTempLatLongFieldsFromPlants < ActiveRecord::Migration
  def self.up
    remove_column :plants, :temp_lat_float
    remove_column :plants, :temp_lon_float
  end

  def self.down
    add_column :plants, :temp_lat_float, :float
    add_column :plants, :temp_lon_float, :float
    Plant.all().each do |plant|
      plant.temp_lat_float = plant.lat
      plant.temp_lon_float = plant.lon
      plant.save
    end
  end
end
