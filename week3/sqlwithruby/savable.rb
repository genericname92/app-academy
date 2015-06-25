module Savable
  def save
    @save ||= {}
    @table_name ||= ""
    QuestionsDatabase.instance.execute(<<-SQL, @table_name, *@save.keys, *@save.values)
      INSERT INTO ?
        (#{'?, ' * (@save.length - 1) + '?'})
      VALUES
        (#{'?,' * (@save.length - 1) + '?'}})
    SQL
  end
end
