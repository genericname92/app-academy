require 'addressable/uri'
require 'rest-client'

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  puts RestClient.post(
    url,
    { user: { username: "Gizmo"} }
  )
end

def create_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts.json'
  ).to_s

  puts RestClient.post(
    url,
    { contact: { name: "Gizmo", email: "gizmo@gizmo.gizmo", user_id: 5 } }
  )
end

def create_contact_share
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contact_shares.json'
  ).to_s

  puts RestClient.post(
    url,
    { contact_share: {contact_id: 5, user_id: 1} }
  )
end

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users.html'
).to_s

def show_user
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1'
  ).to_s

  puts RestClient.get(
    url
  )
end

def update_user
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1'
  ).to_s

  puts RestClient.put( url,  user: { email: "hi5.gmail.com" } )
end

def delete_user
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/2'
  ).to_s

  puts RestClient.delete(url)
end

def delete_contact_share
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/contact_shares/2'
  ).to_s

  puts RestClient.delete(url)
end

def delete_contact
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/contacts/2'
  ).to_s

  puts RestClient.delete(url)
end


delete_contact_share
delete_contact
delete_user
