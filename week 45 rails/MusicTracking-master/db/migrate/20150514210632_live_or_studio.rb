class LiveOrStudio < ActiveRecord::Migration
  def change
    add_column :albums, :album_recording_type, :string, null: false
  end
end
