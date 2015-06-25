class Album < ActiveRecord::Base
  validates :name, :band_id, presence: true
  validates :album_recording_type, inclusion: ["live", "studio"]
  has_many :tracks, dependent: :destroy
  belongs_to :band
end
