class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_respond_to_poll
  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  has_one(
    :poll,
    through: :question,
    source: :poll
  )

  def sibling_responses
    question.responses.where.not(id: id) unless id.nil?
  end

  def respondent_has_not_already_answered_question
    if sibling_responses
      if sibling_responses.where(user_id: user_id).exists?
        errors.add(:already_responded, "User already responded")
        end
    end
  end

  def author_cannot_respond_to_poll
    if question.poll.author == user_id
      errors.add(:author_rigging, "Author cannot respond to poll")
    end
  end

end
