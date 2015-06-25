# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before :each do
    visit new_user_url
  end

  it "has a new user page" do
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      fill_in "Username", with: 'bob'
      fill_in "Password", with: 'bob123'
      click_button 'Sign Up'
      expect(page).to have_content "bob"
    end

  end

end

feature "logging in" do
  it "shows username on the homepage after login" do
    sign_up_as_bob
    click_button "Sign Out"
    visit new_session_url
    sign_in("bob", "bob123")
    expect(page).to have_content 'bob'
  end

end

feature "logging out" do
  it "begins with logged out state" do
    visit new_session_url
    assert has_no_field?('bob')
  end

  it "doesn't show username on the homepage after logout" do
    sign_up_as_bob
    click_button "Sign Out"
    visit new_session_url
    sign_in("bob", "bob123")
    expect(page).to have_content 'bob'
    click_button "Sign Out"
    assert has_no_field?('bob')
  end


end
