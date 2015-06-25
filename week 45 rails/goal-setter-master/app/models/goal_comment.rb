class GoalComment < ActiveRecord::Base
  validates :author_id, :checkpoint_id, :body, presence: true
  belongs_to :checkpoint
  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )
end
