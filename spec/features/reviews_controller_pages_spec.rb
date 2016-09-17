require 'rails_helper'

# describe "the add a review process" do
#   it "adds a new review" do
#     category = Category.create(:name => "Tester" )
#     product = Product.create(:name => "Prop", :category_id => category.id )
#     visit product_path(product)
#     click_on 'Add a review'
#     fill_in 'Name', :with => 'Chips'
#     fill_in 'Content', :with => 'well hello'
#     fill_in 'Rating', :with => '77'
#     click_on 'Create Review'
#     expect(page).to have_content 'Review saved successfully'
#   end
# end
#
# describe "the edit product process" do
#   it "edits a product" do
#     category = Category.create(:name => "Tester" )
#     product = Product.create(:name => "Prop", :category_id => category.id )
#     review = Review.create(:name => 'Flops', :product_id => product.id)
#     visit product_review_path(product, review)
#     click_link 'Edit'
#     fill_in 'Name', :with => 'Chips'
#     fill_in 'Content', :with => 'asdffs'
#     fill_in 'Rating', :with => '5'
#     click_on 'Update Review'
#     expect(page).to have_content 'review updated successfully'
#   end
# end
#
# describe "the delete review process" do
#   it "deletes a review" do
#     category = Category.create(:name => "Tester" )
#     product = Product.create(:name => "Prop", :category_id => category.id )
#     review = Review.create(:name => 'Flops', :product_id => product.id)
#     visit product_review_path(product, review)
#     click_link 'Delete'
#     expect(page).to have_content 'Review deleted'
#   end
# end
