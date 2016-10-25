class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password
      t.integer :congregation_id
      t.string :email
      t.string :fname
      t.string :lname
      t.boolean :isadmin
      t.boolean :iscongadmin
      t.string :mappref
      t.date :lastlogin
      t.string :sitelang
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :users
  end
end
