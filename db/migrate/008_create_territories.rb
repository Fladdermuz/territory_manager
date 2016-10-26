class CreateTerritories < ActiveRecord::Migration
  def self.up
    create_table :territories do |t|
      t.string :territory_no
      t.text :description
      t.text :notes
      t.attachment :image
      t.integer :zone_id
      t.date :last_worked, :default => nil
      t.date  :checkout_date
      t.integer :checked_out_by
      t.boolean :is_checked_in, default: TRUE
      t.integer :client_id
      t.boolean :is_dynamic
      t.string :center_coordinate
      t.integer :zoom
      t.boolean :fill_color
      t.string :border_color
      t.integer :border_size
      t.integer :map_layer_id
      t.boolean :isreserved
      t.string :reserved_by
      t.timestamps null: false


    end
  end

  def self.down
    drop_table :territories
  end
end
