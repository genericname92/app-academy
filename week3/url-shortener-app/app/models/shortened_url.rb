class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, length: {maximum: 1024 }
  validates :submitter_id, presence: true
  validate :not_spam

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :shortened_url_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :url_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :tags,
    through: :taggings,
    source: :tag
  )

  def self.random_code
    code = SecureRandom::urlsafe_base64
    while ShortenedUrl.exists?(code)
      code = SecureRandom::urlsafe_base64
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      :short_url => ShortenedUrl.random_code,
      :long_url => long_url,
      :submitter_id => user.id
    )
  end

  def not_spam
    recently_made = ShortenedUrl.where(:submitter_id => submitter_id)
                    .where("created_at > ?", 1.minutes.ago).count
    if recently_made >= 5
      errors.add(:spammed, "Too much spam")
    end
  end

  def num_uniques
    visitors.count
  end

  def num_clicks
    Visit.select(:user_id).where(:shortened_url_id => id).count
  end

  def num_recent_uniques
    Visit.select(:user_id)
      .where(:shortened_url_id => id)
      .where("created_at > ?", 10.minutes.ago)
      .distinct.count
  end
end
