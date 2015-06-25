class UpdateUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :name
      t.remove :email
      t.string :username
    end
  end
  
end
