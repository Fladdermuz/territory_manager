class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code
      t.string :region
      t.attachment :flag
      t.float :latitude
      t.float :longitude
      t.timestamps null: false
    end
  end
end
