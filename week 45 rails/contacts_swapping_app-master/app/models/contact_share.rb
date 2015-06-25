class ContactShare < ActiveRecord::Base
  validates :contact_id, :user_id, presence: true
  validates :contact_id, :uniqueness => {:scope => :user_id}

  belongs_to :user
  belongs_to :contact
  has_many(
    :shared_users,
    through: :contact,
    source: :owner
  )

  has_many :comments, as: :commentable
end
