class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types do |t|
      t.string :name
      t.string :image
      t.integer :growth_factor

      t.timestamps
    end
  end

  def self.down
    drop_table :types
  end
end
