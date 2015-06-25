class Track < ActiveRecord::Base
  validates :name, presence: true
  validates :track_bonus, inclusion: ["bonus", "regular"]
  belongs_to :album
  has_many :notes, dependent: destroy
end
