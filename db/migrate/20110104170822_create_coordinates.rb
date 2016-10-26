class CreateCoordinates < ActiveRecord::Migration
  def self.up
    create_table :coordinates do |t|
      t.integer :territory_id
      t.integer :zone_id
      t.string :coordinate
      t.timestamps
    end
  end

  def self.down
    drop_table :coordinates
  end
end
