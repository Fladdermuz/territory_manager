class CreateZones < ActiveRecord::Migration
  def self.up
    create_table :zones do |t|
      t.string :zone_no
      t.text :description
      t.integer :client_id
      t.string :center_coordinate
      t.integer :zoom
      t.string :city
      t.string :state
      t.integer :country_id
      t.boolean :fill_color
      t.string :border_color
      t.integer :border_size
      t.integer :map_layer_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :zones
  end
end
