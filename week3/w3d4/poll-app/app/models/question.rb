class Question < ActiveRecord::Base
  validates :poll_id, presence: true
  validates :question_body, presence: true

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses,
  )

  # def results
  #   results = {}
  #   answer_choices.each do |answer_choice|
  #     results[answer_choice.answer_body] = answer_choice.responses.count
  #   end
  #   results
  # end

  def results
    counts = answer_choices.select("answer_choices.answer_body, COUNT(user_id) AS num_responses")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .group("answer_choices.id")
    counts.map do |answer|
      [answer.answer_body, answer.num_responses]
    end
  end

end
