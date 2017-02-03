require 'rails_helper'

describe "the add a category process", js: true do
  it "adds a new category" do
    user = FactoryGirl.create(:user)
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => 'frank@frank.frank'
    fill_in 'Password', :with => 'password'
    click_on 'Log in'
    click_link 'new_category_link'
    fill_in 'Name', :with => 'Chips'
    click_on 'Create Category'
    expect(page).to have_content 'Chips'
  end
end

describe "the edit category process" do
  it "edits a category" do
    user = FactoryGirl.create(:user)
    category = FactoryGirl.create(:category)
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => 'frank@frank.frank'
    fill_in 'Password', :with => 'password'
    click_on 'Log in'
    first('#categories').click_link('Bratwurst')
    click_link 'Edit Category'
    fill_in 'Name', :with => 'Chips'
    click_on 'Update Category'
    expect(page).to have_content 'Chips'
  end
end

describe "the delete category process" do
  it "deletes a category" do
    user = FactoryGirl.create(:user)
    category = FactoryGirl.create(:category)
    visit '/'
    click_on 'Login'
    fill_in 'Email', :with => 'frank@frank.frank'
    fill_in 'Password', :with => 'password'
    click_on 'Log in'
    first('#categories').click_link('Bratwurst')
    click_link 'Delete Category'
    expect(page).to have_content 'Category and associated products deleted'
  end
end
