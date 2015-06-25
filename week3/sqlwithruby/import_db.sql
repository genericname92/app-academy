DROP Table question_follows;
drop table question_likes;
drop table replies;
drop table questions;
drop table users;



CREATE TABLE users (
  id integer PRIMARY KEY autoincrement,
  fname string NOT NULL,
  lname string NOT NULL
  );
CREATE TABLE questions (
  id integer PRIMARY KEY autoincrement,
  title string NOT NULL,
  body string NOT NULL,
  author_id integer references users(id) NOT NULL
);
CREATE TABLE question_follows (
  id integer PRIMARY KEY autoincrement,
  user_id integer references user(id),
  question_id integer references questions(id)
);
CREATE TABLE replies (
  id integer PRIMARY KEY autoincrement,
  question_id integer references questions(id) NOT NULL,
  parent_id integer references replies(id),
  user_id integer references users(id) NOT NULL,
  body String NOT NULL
);
CREATE TABLE question_likes (
  id integer PRIMARY KEY autoincrement,
  question_id integer references questions(id) NOT NULL,
  user_id integer references users(id) NOT NULL
);

INSERT into users (fname, lname) values ("Andy", "Asher"), ("Bob", "Burger");
INSERT into
  questions
  (title, body, author_id)
values
  ("Hi world", "Where is SF", 1), ("Bye world", "On the golden gate bridge", 2),
  ("Blah", "blahblahblah", 1);

INSERT INTO question_follows (user_id, question_id) values (1, 2);

insert into replies (question_id, user_id, body) values (2, 1, "Chin up fellow");
insert into question_likes (question_id, user_id) values (2, 1);
