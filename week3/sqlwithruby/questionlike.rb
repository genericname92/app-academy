class QuestionLike
  attr_reader :user_id, :question_id, :id
  def initialize(args = {})
    @user_id, @question_id = args["user_id"], args["question_id"]
    @id = args["id"]
    @save = { "user_id" => @user_id, "question_id" => @question_id }
    @table_name = "question_likes"
  end
  def self.find_by_id(number)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, number)
      Select * from question_likes where ? = id;
    SQL
    raise "Entry not found" if raw_data.empty?
    QuestionLike.new(raw_data[0])
  end

  def self.likers_for_question_id(question_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      select users.id, fname, lname from question_likes
      join
       users on question_likes.user_id = users.id
      where
        ? = question_id
      SQL
    raise "No entries" if raw_data.empty?
    users = []
    raw_data.each do |entry|
      users << User.new(entry)
    end
    users
  end

  def self.num_likes_for_question_id(question_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      select count(user_id) as num from question_likes
      where
        ? = question_id
      group by question_id
      SQL
      return 0 if raw_data.empty?
      raw_data[0]["num"]
  end

  def self.liked_questions_for_user_id(user_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      select title, body, questions.id as id, questions.author_id as author_id from question_likes
      join
       questions on question_likes.question_id = questions.id
      where
        ? = user_id
      SQL
    raise "No entries" if raw_data.empty?
    questions = []
    raw_data.each do |entry|
      questions << Question.new(entry)
    end
    questions
  end

  def self.most_liked_questions(n)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, n)
      select title, body, questions.id as id, questions.author_id as author_id
      from question_likes
      join questions on question_likes.question_id = questions.id
      group by title, body, questions.id, questions.author_id
      order by count(user_id) limit ?
      SQL
    questions = []
    raw_data.each { |entry| questions << Question.new(entry) }
    questions
  end
end
