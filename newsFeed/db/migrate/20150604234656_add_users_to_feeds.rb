class AddUsersToFeeds < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id, null: false
      t.integer :feed_id, null: false

      t.timestamps
    end
    add_index :subscriptions, :user_id
    add_index :subscriptions, :feed_id
  end
end
