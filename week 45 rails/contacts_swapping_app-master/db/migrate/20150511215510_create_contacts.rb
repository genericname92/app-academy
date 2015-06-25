class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null:false

      t.timestamps null: false
    end
    add_index :contacts, :email
  end
end
