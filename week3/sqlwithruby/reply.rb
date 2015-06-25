class Reply
  attr_reader :user_id, :question_id, :parent_id, :body, :id

  def initialize(args = {})
    @user_id, @question_id = args["user_id"], args["question_id"]
    @parent_id, @body = args["parent_id"], args["body"]
    @id = args["id"]
  end

  def self.find_by_id(number)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, number)
      Select * from replies where ? = id;
    SQL
    raise "Entry not found" if raw_data.empty?
    Question.new(raw_data[0])
  end
  def self.find_by_user_id(user_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      Select * from replies where ? = user_id;
    SQL
    raise "Entry not found" if raw_data.empty?
    users = []
    raw_data.each do |entry|
      users << Reply.new(entry)
    end
    users
  end

  def self.find_by_question_id(question_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      Select * from replies where ? = question_id;
    SQL
    raise "Entry not found" if raw_data.empty?
    users = []
    raw_data.each do |entry|
      users << Reply.new(entry)
    end
    users
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, @id)
      Select * from replies where ? = parent_id;
    SQL
    raise "Entry not found" if raw_data.empty?
    child_replies = []
    raw_data.each do |entry|
      child_replies << Reply.new(entry)
    end
    child_replies
  end


end
