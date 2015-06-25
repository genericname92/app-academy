class CreateCheckpoints < ActiveRecord::Migration
  def change
    create_table :checkpoints do |t|
      t.string :title, null: false
      t.integer :user_id, null: false
      t.string :viewable, null: false

      t.timestamps null: false
    end
  end
end
