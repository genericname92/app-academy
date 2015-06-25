class Bonustrack < ActiveRecord::Migration
  def change
    add_column :tracks, :track_bonus, :string, null: false
  end
end
