require 'rails_helper'

describe "the add a product process" do
  it "adds a new product" do
    category = Category.create(:name => "Tester" )
    visit category_path(category)
    click_on 'Add a product'
    fill_in 'Name', :with => 'Chips'
    fill_in 'Price', :with => '5'
    fill_in 'Image', :with => 'None'
    click_on 'Create Product'
    expect(page).to have_content 'Product saved successfully'
  end
end

describe "the edit product process" do
  it "edits a product" do
    category = Category.create(:name => "Tester" )
    product = Product.create(:name => "Prop", :category_id => category.id )
    visit category_path(category)
    click_link 'Prop'
    click_on 'Edit'
    fill_in 'Name', :with => 'Chips'
    fill_in 'Price', :with => '4'
    fill_in 'Image', :with => 'None'
    click_on 'Update Product'
    expect(page).to have_content 'product updated successfully'
  end
end

describe "the delete a product process" do
  it "deletes a product" do
    category = Category.create(:name => "Tester" )
    product = Product.create(:name => "Prop", :category_id => category.id )
    visit category_path(category)
    click_link 'Prop'
    click_on 'Delete'
    expect(page).to have_content 'Product and associated reviews deleted'
  end
end
