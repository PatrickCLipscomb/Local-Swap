require 'rails_helper'

describe "the add a product process", js: true do
  it "adds a new product" do
    user = FactoryGirl.create(:user)
    category = FactoryGirl.create(:category)
    visit categories_path
    click_on 'Login'
    fill_in 'Email', :with => 'frank@frank.frank'
    fill_in 'Password', :with => 'password'
    click_on 'Log in'
    visit user_path(user)
    click_on 'Post'
    fill_in 'Name', :with => 'Chips'
    fill_in 'Price', :with => '5'
    choose 'category_id_' + category.id.to_s
    click_on 'Create Product'
    expect(page).to have_content 'Chips'
  end
end

describe "the edit product process", js: true do
  it "edits a product" do
    user = FactoryGirl.create(:user)
    category = FactoryGirl.create(:category)
    visit categories_path
    click_on 'Login'
    fill_in 'Email', :with => 'frank@frank.frank'
    fill_in 'Password', :with => 'password'
    click_on 'Log in'
    visit user_path(user)
    click_on 'Post'
    fill_in 'Name', :with => 'Chips'
    fill_in 'Price', :with => '5'
    choose 'category_id_' + category.id.to_s
    click_on 'Create Product'
    click_link 'Chips'
    click_on 'Edit Product'
    fill_in 'Name', :with => 'Chipers'
    fill_in 'Price', :with => '4'
    choose 'category_id_' + category.id.to_s
    click_on 'Update Product'
    expect(page).to have_content 'Chipers'
  end
end

describe "the delete a product process", js: true do
  it "deletes a product" do
    user = FactoryGirl.create(:user)
    category = FactoryGirl.create(:category)
    visit categories_path
    click_on 'Login'
    fill_in 'Email', :with => 'frank@frank.frank'
    fill_in 'Password', :with => 'password'
    click_on 'Log in'
    visit user_path(user)
    click_on 'Post'
    fill_in 'Name', :with => 'Chips'
    fill_in 'Price', :with => '5'
    choose 'category_id_' + category.id.to_s
    click_on 'Create Product'
    click_link 'Chips'
    click_on 'Delete'
    expect(page).to have_content 'Product and associated reviews deleted'
  end
end
