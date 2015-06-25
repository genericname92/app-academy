class TagTopic < ActiveRecord::Base
  validates :tag, presence: true, uniqueness: true, length: { maximum: 20 }

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :tag_id,
    primary_key: :id
  )

  has_many(
    :urls,
    through: :taggings,
    source: :shortened_url
  )

  def most_popular_links(n)
    # select short_url from,       self.id
    # tag_topics inner
    # join taggings join shortened_urls LEFT OUTER JOIN visits
    # where tagtopic.id = ?,
    # group by short_url
    # order by count(visits) DESC limit n

    urls = self.urls.includes(:visits)

    url_visits_counts = {}

    urls.each do |url|
      url_visits_counts[url] = url.visits.length
    end

    url_visits_counts = url_visits_counts.sort_by { |key, value| value }.reverse
    url_visits_counts.take(n)
  end

end
