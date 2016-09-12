require 'rails_helper'

describe "the add a category process" do
  it "adds a new category" do
    visit categories_path
    click_link 'Add a category'
    fill_in 'Name', :with => 'Chips'
    fill_in 'Image', :with => 'None'
    click_on 'Create Category'
    expect(page).to have_content 'Category saved successfully'
  end
end

describe "the edit category process" do
  it "edits a category" do
    category = Category.create(:name => "Tester" )
    visit category_path(category)
    click_link 'Edit'
    fill_in 'Name', :with => 'Chips'
    fill_in 'Image', :with => 'None'
    click_on 'Update Category'
    expect(page).to have_content 'Chips'
  end
end

describe "the delete category process" do
  it "deletes a category" do
    category = Category.create(:name => "Tester" )
    visit category_path(category)
    click_link 'Delete'
    expect(page).to have_content 'Are you sure?'
  end
end

describe "the edit product process" do
  it "edits a product" do
    product = Product.create(:name => "Tester" )
    visit product_path(product)
    click_link 'Edit'
    fill_in 'Name', :with => 'Chips'
    fill_in 'Price', :with => '4'
    fill_in 'Image', :with => 'None'
    click_on 'Update Product'
    expect(page).to have_content 'product updated successfully'
  end
end
