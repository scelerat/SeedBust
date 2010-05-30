class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :fb_id
      t.string :fb_first_name
      t.string :fb_last_name
      t.string :fb_link
      t.integer :fb_last_lat
      t.integer :fb_last_lon
      t.string :role, :default => 'active'
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
