class AddTypeToPlants < ActiveRecord::Migration
  def self.up
    add_column :plants, :type_id, :integer
  end

  def self.down
    remove_column :plants, :type_id
  end
end
