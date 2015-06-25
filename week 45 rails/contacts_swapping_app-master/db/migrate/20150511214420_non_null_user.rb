class NonNullUser < ActiveRecord::Migration
  def change
    remove_column :users, :username
    add_column :users, :username, :string, null: false, default: "unknown"
    add_index :users, :username, :unique => true
  end
end
