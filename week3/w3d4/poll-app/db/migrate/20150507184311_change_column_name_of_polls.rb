class ChangeColumnNameOfPolls < ActiveRecord::Migration
  def change
    rename_column :polls, :author, :author_id
  end
end
