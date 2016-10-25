class CreateTerritories < ActiveRecord::Migration
  def self.up
    create_table :territories do |t|
      t.string :territory_no
      t.text :descrip
      t.text :notes
      t.string :img_url
      t.integer :zone_id
      t.date :last_worked, :default => nil
      t.date  :checkout_date
      t.text :checked_out_by
      t.boolean :is_checked_in, default: TRUE
      t.integer :congregation_id
      t.boolean :is_dynamic
      t.string :center_coordinate
      t.attachment :image
      t.integer :zoom
      t.string :color
      t.string :border_color
      t.string :maptype
      t.boolean :isreserved, default: FALSE
      t.string :reserved_by
      t.timestamps null: false


    end
  end

  def self.down
    drop_table :territories
  end
end
