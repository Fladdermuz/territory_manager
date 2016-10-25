class CreateMapLayers < ActiveRecord::Migration
  def change
    create_table :map_layers do |t|
      t.string :name
      t.string :layer_url
      t.string :provider
      t.text :api_key
      t.integer :max_zoom
      t.integer :min_zoom
      t.boolean :is_mapbox, default: FALSE
      t.string :map_type
      t.string :file_ext
      t.string :subdomains
      t.timestamps null: false
    end
  end
end
