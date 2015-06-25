require 'spec_helper'
require 'rails_helper'

feature "creating goal" do
  before :each do
    sign_up_as_bob
    click_button 'Sign Out'
  end

  it "redirects to sign in page if not logged in" do
    visit '/users/1'
    expect(page).to have_content 'Must Log In'
  end

  it "Creates a goal" do
    bob = build(:user)
    sign_in(bob.username, bob.password)
    visit user_url(1)
    save_and_open_page
    fill_in 'Title', with: 'Rails Master'
    page.select("Public", from: 'viewable')
    click_button 'Add Goal'
    expect(page).to have_content 'Rails Master'
  end

  it "Validates form inputs" do
    sign_in("bob", "bob123")
    visit '/users/1'
    page.select("Public", from: 'viewable')
    click_button 'Add Goal'
    expect(page).to have_content "Title can't be blank"
  end


end

feature "editing goal" do
  before :each do
    sign_up_as_bob
    visit '/users/1'
  end

  it "Edits goal" do

    fill_in 'Title', with: 'RailMaster'
    select("Private", from: 'viewable')
    click_button "Add Goal"
    expect(page).to have_content "RailMaster"
    click_button "Edit Goal"
    fill_in 'Title', with: "Not a thang"
    select("Private", from: 'viewable')
    click_button "Edit Goal"
    expect(page).to have_content "Not a thang"
  end

  it "validates form inputs" do
    fill_in 'Title', with: 'RailMaster'
    select("Private", from: 'viewable')
    click_button "Add Goal"
    expect(page).to have_content "RailMaster"
    #Created a goal
    click_button "Edit Goal"
    fill_in 'Title', with: ""
    select("Private", from: 'viewable')
    click_button "Edit Goal"
    expect(page).to have_content "Title can't be blank"

  end

end

feature "destroys goals" do
  before :each do
    sign_up_as_bob
    visit '/users/1'
  end

  it "should have a button to destroy the goal" do
    fill_in 'Title', with: 'Rails Master'
    select("Public", from: 'viewable')
    click_button 'Add Goal'
    page.should have_selector(:button, "Destroy Goal")
  end

  it "should destroy goal upon click" do
    fill_in 'Title', with: 'Rails Master'
    select("Public", from: 'viewable')
    click_button 'Add Goal'
    click_button 'Destroy Goal'
    expect(page).to have_content "No Goals"
  end

end
