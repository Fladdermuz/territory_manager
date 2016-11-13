class CreateWarningMessages < ActiveRecord::Migration
  def change
    create_table :warning_messages do |t|
      t.integer :user_id
      t.string :msg_name
      t.boolean :hide

      t.timestamps null: false
    end
  end
end
