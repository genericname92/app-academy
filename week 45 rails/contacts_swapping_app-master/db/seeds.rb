a = User.new(username: 'Andy')
b = User.new(username: 'bob')
c = User.new(username: 'cat')
d = User.new(username: 'dog')
a.save!
b.save!
c.save!
d.save!

ac = Contact.new(name: 'Andy', email: "andy@gmail.com", user_id: 1)
bc = Contact.new(name: 'bob', email: "bob@gmail.com", user_id: 2)
cc = Contact.new(name: 'cat', email: "cat@gmail.com", user_id: 3)
dc = Contact.new(name: 'dog', email: "dog@gmail.com", user_id: 4)
ac.save!
bc.save!
cc.save!
dc.save!

acs = ContactShare.new(contact_id: 2, user_id: 1)
bcs = ContactShare.new(contact_id: 3, user_id: 4)
ccs = ContactShare.new(contact_id: 1, user_id: 4)

acs.save!
bcs.save!
ccs.save!
