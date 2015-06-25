class Checkpoint < ActiveRecord::Base
  validates :user_id, :title, presence: true
  validates :viewable, inclusion: { in: ['public', 'private'] }
  belongs_to :user
end
