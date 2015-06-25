class AddUserIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :user_id, :integer, null: false, default: 0
    add_index :contacts, [:user_id,:email], unique: true
  end
end
