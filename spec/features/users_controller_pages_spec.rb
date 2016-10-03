require 'rails_helper'

describe "the add a user process" do
  it "adds a new user" do
    visit categories_path
    click_on 'Sign Up'
    fill_in 'User name', :with => 'Chips'
    fill_in 'Email', :with => 'well@hello.gud'
    fill_in 'Address', :with => '100 N Blandena, Portland'
    fill_in 'Password', :with => 'password'
    fill_in 'Password confirmation', :with => 'password'
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end

describe "the Login a user process" do
  it "adds a logins a user" do
    user = FactoryGirl.create(:user)
    visit categories_path
    click_on 'Login'
    fill_in 'Email', :with => 'frank@frank.frank'
    fill_in 'Password', :with => 'password'
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end

describe "the Logout user process" do
  it "adds a logins a user" do
    user = FactoryGirl.create(:user)
    visit categories_path
    click_on 'Login'
    fill_in 'Email', :with => 'frank@frank.frank'
    fill_in 'Password', :with => 'password'
    click_on 'Log in'
    click_on 'Logout'
    expect(page).to have_content 'Signed out successfully'
  end
end

describe "the edit a user process" do
  it "adds a logins a user" do
    user = FactoryGirl.create(:user)
    visit categories_path
    click_on 'Login'
    fill_in 'Email', :with => 'frank@frank.frank'
    fill_in 'Password', :with => 'password'
    click_on 'Log in'
    click_on 'Edit Profile'
    fill_in 'User name', :with => 'Chips'
    fill_in 'Current password', :with => 'password'
    click_on 'Update'
    expect(page).to have_content 'Your account has been updated successfully.'
  end
end
