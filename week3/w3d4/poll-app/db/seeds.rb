require 'byebug'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'securerandom'

bob = User.find_or_create_by!(user_name: 'Bob')
cat = User.find_or_create_by!(user_name: 'Cat')
dog = User.find_or_create_by!(user_name: 'Dog')
ed = User.find_or_create_by!(user_name: 'Ed')

p1 = Poll.find_or_create_by!(title: 'What is the meaning of life', author: bob)
p2 = Poll.find_or_create_by!(title: 'Where am I?', author: cat)
p3 = Poll.find_or_create_by!(title: 'What is this?', author: dog)

questions = []
questions << Question.find_or_create_by!(poll: p1, question_body: 'What is a question')
questions << Question.find_or_create_by!(poll: p1, question_body: 'What is a statement')
questions << Question.find_or_create_by!(poll: p1, question_body: 'What is an exclaimation mark')
questions << Question.find_or_create_by!(poll: p2, question_body: 'Where is SF')
questions << Question.find_or_create_by!(poll: p2, question_body: 'Where is California')
questions << Question.find_or_create_by!(poll: p3, question_body: 'IS this computer science')

answer_choices = []
(0..5).each do |i|
  4.times do
    answer_choices << AnswerChoice.find_or_create_by!(question: questions[i], answer_body: SecureRandom.hex)
  end
end

Response.find_or_create_by!(respondent: bob, answer_choice: answer_choices[17])
Response.find_or_create_by!(respondent: cat, answer_choice: answer_choices[12])
Response.find_or_create_by!(respondent: cat, answer_choice: answer_choices[22])
Response.find_or_create_by!(respondent: cat, answer_choice: answer_choices[2])
Response.find_or_create_by!(respondent: ed, answer_choice: answer_choices[1])
Response.find_or_create_by!(respondent: ed, answer_choice: answer_choices[6])
Response.find_or_create_by!(respondent: ed, answer_choice: answer_choices[9])
