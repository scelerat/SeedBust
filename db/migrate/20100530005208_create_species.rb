class CreateSpecies < ActiveRecord::Migration
  def self.up
    create_table :species do |t|
      t.string :name
      t.string :image, :default => "default.png"
      t.integer :growth_factor

      t.timestamps
    end
  end

  def self.down
    drop_table :species
  end
end
