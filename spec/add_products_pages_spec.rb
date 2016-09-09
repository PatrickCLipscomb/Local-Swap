require 'rails_helper'

describe "the add a product process" do
  it "adds a new product" do
    category = Category.create(name: "Best")
    visit category_path(category)
    click_link 'Add a product'
    fill_in 'Name', :with => 'Peter'
    fill_in 'Price', :with => '2'
    fill_in 'Image', :with => 'Guy'
    click_on 'Create Product'
    expect(page).to have_content 'Product Saved Successfully'
  end

end
