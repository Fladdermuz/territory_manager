class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :neighborhood
      t.string :house_no
      t.string :street
      t.string :apt_no
      t.string :city
      t.string :state
      t.boolean  :hide_map, default: FALSE
      t.integer :zip
      t.date :call_date
      t.integer :territory_id
      t.integer :client_id
      t.string :coordinate
      t.string :alt_house_no
      t.string :alt_street
      t.string  :alt_city
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :addresses
  end
end
