require_relative 'require_stuff'


class User
  attr_accessor :fname, :lname, :id

  def initialize(args = {})
    @fname = args["fname"]
    @lname = args["lname"]
    @id = args["id"]
    @table_name = "users"
  end
#hash was betterer
  def save
    if User.find_by_id(@id).nil?

      string = "Insert into #{@table_name} ("
      instance_variables.each do |instance|
        string.concat("#{instance.to_s[1..-1]}, ") unless instance == instance_variables.last
      end
      string.concat("#{instance_variables.last.to_s[1..-1]}) VALUES (")
      instance_variables.each do |var|
        instance_var = var.to_s
        value = self.instance_variable_get(instance_var)
        string.concat(value.to_s + ',')
      end
      string = string[0...-1]
      string += ")"
      puts string
      QuestionsDatabase.instance.execute(string)
    else
      string = "UPDATE #{@table_name} SET "
      instance_variables.each do |instance|
        value = instance_variable_get(instance.to_s)
        string.concat("#{instance.to_s} = #{value.to_s} ")
      end
      string.concat("Where id = #{@id}")
      puts string
      QuestionsDatabase.instance.execute(string)
    end

    @id = QuestionsDatabase.last_insert_row_id
  end

  def self.find_by_id(number)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, number)
      Select * from users where ? = id;
    SQL
    return nil if raw_data.empty?
    User.new(raw_data[0])
  end

  def self.find_by_name(fname, lname)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      select * from users where fname = ? AND lname = ?
    SQL
    raise "Entry not found" if raw_data.empty?
    users = []
    raw_data.each do |entry|
      users << User.new(entry)
    end
    users
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, @id)
      select
        CAST(count(user_id)/count(DISTINCT(title)) AS FLOAT)
      from
        questions
      left outer join
        question_likes
      on
        question_likes.question_id = questions.id
      where
        ? = questions.author_id
      group by author_id
      SQL
      raise "No posts" if raw_data.empty?
      raw_data[0]
  end
end

carl = User.new({"fname" => "Carl", "lname" => "Jones"})
carl.save
p QuestionsDatabase.instance.execute("SELECT * FROM users")
