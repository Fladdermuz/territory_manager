class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password
      t.integer :client_id
      t.string :email
      t.string :fname
      t.string :lname
      t.boolean :isadmin , default: FALSE
      t.boolean :must_change_pass, default: FALSE
      t.boolean :can_manage_hh, default: FALSE
      t.boolean :is_client_admin
      t.date :lastlogin
      t.string :sitelang
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :users
  end
end
