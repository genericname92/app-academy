class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(
    :authored_polls,
    class_name: 'Poll',
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :user_id,
    primary_key: :id
  )

  def completed_polls
    num_poll_responses =
    Poll.find_by_sql([<<-SQL, {user_id: id}])
    SELECT
      polls.*, COUNT(responses.user_id) AS 'user_responses'
    FROM
     polls
    JOIN
      questions ON questions.poll_id = polls.id
    JOIN
      answer_choices ON answer_choices.question_id = questions.id
    JOIN
      responses ON responses.answer_choice_id = answer_choices.id
    WHERE
      responses.user_id = :user_id
    GROUP BY
      polls.id;
    SQL

    num_poll_questions =
    Poll.find_by_sql("
    SELECT
      polls.*, COUNT(questions.id) AS 'poll_questions'
    FROM
      polls
    JOIN
      questions ON questions.poll_id = polls.id
    GROUP BY
      polls.id;"
    )
    output = []
    num_poll_questions.each do |poll_question|
      output << num_poll_responses.select do |poll_response|
        poll_question.id == poll_response.id && poll_question.poll_questions == poll_response.user_responses
      end
    end
    output.flatten.compact
  end

end
