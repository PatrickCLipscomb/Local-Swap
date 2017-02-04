require 'rails_helper'

describe "the add a review process" do
  it "adds a new review" do
    user = FactoryGirl.create(:user)
    visit '/'
    click_link "Sign Up"
    fill_in "user_user_name", :with => "Sample User"
    fill_in "user_email", :with => "sample@email.com"
    fill_in "user_address", :with => "100 N Blandena, Portland, OR"
    fill_in "user_bio", :with => "I am a smaple user"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    click_on "Sign up"
    visit '/users/' + user.id.to_s
    click_link 'add_review_link'
    fill_in 'Content', :with => 'well hello, this is a review'
    choose 'rating_2'
    click_on 'Create Review'
    expect(page).to have_content 'well hello, this is a review'
  end
end

describe "the edit product process" do
  it "edits a product" do
    user = FactoryGirl.create(:user)
    visit '/'
    click_link "Sign Up"
    fill_in "user_user_name", :with => "Sample User"
    fill_in "user_email", :with => "sample@email.com"
    fill_in "user_address", :with => "100 N Blandena, Portland, OR"
    fill_in "user_bio", :with => "I am a smaple user"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    click_on "Sign up"
    visit '/users/' + user.id.to_s
    click_link 'add_review_link'
    fill_in 'Content', :with => 'well hello, this is a review'
    choose 'rating_2'
    click_on 'Create Review'
    click_link "Rating Page"
    click_link "Edit"
    fill_in "review_content", :with => "Updated Review Content"
    choose "rating_5"
    click_on "Update Review"
    expect(page).to have_content 'review updated successfully'
  end
end

describe "the delete review process" do
  it "deletes a review" do
    user = FactoryGirl.create(:user)
    visit '/'
    click_link "Sign Up"
    fill_in "user_user_name", :with => "Sample User"
    fill_in "user_email", :with => "sample@email.com"
    fill_in "user_address", :with => "100 N Blandena, Portland, OR"
    fill_in "user_bio", :with => "I am a smaple user"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    click_on "Sign up"
    visit '/users/' + user.id.to_s
    click_link 'add_review_link'
    fill_in 'Content', :with => 'well hello, this is a review'
    choose 'rating_2'
    click_on 'Create Review'
    click_link "Rating Page"
    click_link 'Delete'
    expect(page).to have_content 'Review deleted'
  end
end
