class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code
      t.string :region
      t.attachment :flag   
      t.timestamps null: false
    end
  end
end
