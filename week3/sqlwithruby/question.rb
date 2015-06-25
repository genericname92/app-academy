class Question
  attr_reader :title, :body, :author_id, :id

  def initialize(args = {})
    @title = args["title"]
    @body = args["body"]
    @author_id = args["author_id"]
    @id = args["id"]
  end

  def self.find_by_id(num)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, num)
      Select * from questions where ? = id;
    SQL
    raise "Entry not found" if raw_data.empty?
    Question.new(raw_data[0])
  end

  def self.find_by_author_id(author_id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      Select * from questions where ? = author_id;
    SQL
    raise "Entry not found" if raw_data.empty?
    questions = []
    raw_data.each do |entry|
      questions << Question.new(entry)
    end
    questions
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
end
