class CreateTerritoryHistories < ActiveRecord::Migration
  def self.up
    create_table :territory_histories do |t|
      t.integer :territory_id
      t.date :check_out_date
      t.date :check_in_date
      t.string :checked_out_by
      t.integer :client_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :territory_histories
  end
end
