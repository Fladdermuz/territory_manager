class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.integer :country_id
      t.string :language
      t.string :coordinate, default: "38.802859, -96.208728"
      t.boolean :disable_terr_maps, default: FALSE
      t.boolean :disable_all_google_maps, default: FALSE
      t.boolean :is_coordinate_only, default: FALSE
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :clients
  end
end
