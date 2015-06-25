# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  birth_date  :date             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base

  CAT_COLORS = %w(ginger yellow brown calico buff marmalade orange seal chocolate)

  validates :color, :name, :sex, :birth_date, presence: true
  validates :sex, inclusion: { in: %w(M F),
    message: "%{value} is not a valid sex" }
  validates :color, inclusion: {
    in: %w(ginger yellow brown calico buff marmalade orange seal chocolate),
    message: "%{value} is not a valid color" }

  def age
    now = Time.now.utc.to_date
    now.year - birth_date.year -
      ((now.month > birth_date.month ||
      (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end

  has_many(
    :cat_rental_requests,
    class_name: 'CatRentalRequest',
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
    )
end
