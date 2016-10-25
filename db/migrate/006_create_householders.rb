class CreateHouseholders < ActiveRecord::Migration
  def self.up
    create_table :householders do |t|
      t.string :fname
      t.string :lname
      t.text :notes
      t.text :phone
      t.integer :address_id
      t.date :call_date
      t.integer :congregation_id
      t.timestamps null: false

    end
  end

  def self.down
    drop_table :householders
  end
end
