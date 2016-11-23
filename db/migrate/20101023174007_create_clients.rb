class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.integer :country_id
      t.float :latitude
      t.float :longitude
      t.string :language
      t.string :center_coordinate
      t.boolean :is_coordinate_only, default: FALSE
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :clients
  end
end
