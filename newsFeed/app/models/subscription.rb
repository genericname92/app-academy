class Subscription < ActiveRecord::Base
  validates :user_id, :feed_id, presence: true

  belongs_to :user
  belongs_to(
    :feed,
    class_name: "Feed",
    primary_key: :id,
    foreign_key: :feed_id)
end
