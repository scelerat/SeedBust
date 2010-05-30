class CreatePlants < ActiveRecord::Migration
  def self.up
    create_table :plants do |t|
      t.integer :parent_plant_id
      t.integer :planted_user_id
      t.integer :origin_user_id
      t.string :name
      t.string :state
      t.integer :plant_id
      t.date :date_planted 
      t.integer :lat, :default => 0
      t.integer :lon, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :plants
  end
end
