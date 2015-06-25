class QuestionFollow

  attr_reader :user_id, :question_id

  def initialize(args = {})
    @user_id, @question_id = args["user_id"], args["question_id"]
  end

  def self.find_by_id(number)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, number)
      Select * from question_follows where ? = id;
    SQL
    raise "Entry not found" if raw_data.empty?
    QuestionFollow.new(raw_data[0])
  end

  def self.followers_for_question_id(question_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      select users.id as id, fname, lname
      from question_follows
      join users on users.id = question_follows.user_id
      where
        ? = question_id
      SQL
    raise "Entry not found" if raw_data.empty?
    users = []
    raw_data.each do |entry|
      users << User.new(entry)
    end

    users
  end

  def self.followed_questions_for_user_id(user_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      select questions.id as id,
        questions.body as body,
        questions.author_id as author_id,
        questions.title as title
      from question_follows
      join questions on questions.id = questions_follow.question_id
      where ? = user_id
      SQL
    questions = []
    raw_data.each do |entry|
      questions << Question.new(entry)
    end

    questions
  end

#SHould we be outputting question objects
  def self.most_followed_questions(n)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, n)
        select
          questions.title as title,
          questions.id as id,
          questions.author_id as author_id,
          questions.body as body
        from questions
        join question_follows on questions.id = question_follows.question_id
        GROUP BY title
        ORDER BY count(user_id) DESC limit ?
    SQL
    questions = []
    raw_data.each do |entry|
      questions << Question.new(entry)
    end
    questions
  end
end
