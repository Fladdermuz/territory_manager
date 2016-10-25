class CreateZones < ActiveRecord::Migration
  def self.up
    create_table :zones do |t|
      t.integer :zone_no
      t.text :descrip
      t.string :img_url
      t.integer :congregation_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :zones
  end
end
