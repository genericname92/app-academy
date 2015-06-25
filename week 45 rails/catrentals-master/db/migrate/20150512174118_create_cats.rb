class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :color, null: false
      t.string :name, null: false
      t.string :sex, null: false
      t.text :description
      t.date :birth_date, null: false

      t.timestamps null: false
    end

    add_index :cats, :name
    add_index :cats, :birth_date
  end
end
