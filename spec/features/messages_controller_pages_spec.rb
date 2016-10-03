require 'rails_helper'

describe "the create a message process" do
  it "will send a message" do
    user = FactoryGirl.create(:user)
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => 'frank@frank.frank'
    fill_in 'Password', :with => 'password'
    click_on 'Log in'
    click_on 'Your Conversations'
    click_on 'Start conversation'
    fill_in 'Subject', :with => "first message"
    fill_in 'Message', :with => "this is my first message to you"
    select "Admin"
    click_on 'Send'
    expect(page).to have_content 'first message'
  end
end
