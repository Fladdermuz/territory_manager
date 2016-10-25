class CreateCongregations < ActiveRecord::Migration
  def self.up
    create_table :congregations do |t|
      t.string :congname
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :language
      t.integer :contact_id
      t.boolean :disable_terr_maps, default: FALSE
      t.boolean :disable_all_google_maps, default: FALSE
      t.boolean :is_coordinate_only, default: FALSE
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :congregations
  end
end
