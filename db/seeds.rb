# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

Category.all.each {|c| c.destroy}
Product.all.each {|p| p.destroy}
User.all.each {|u| u.destroy}
Review.all.each {|r| r.destroy}
ChatRoom.all.each {|c| c.destroy}

def range (min, max)
  rand * (max-min) + min
end

10.times do
  Category.create!(name: Faker::Commerce.department(2, true))
end

8.times do
  User.create!(user_name: Faker::Name.name, email: Faker::Internet.email, address: Faker::Address.street_address, password: 'password')
end

User.all.each {|a| a.update(bio: Faker::Lorem.paragraph, latitude: range(45.4, 45.6), longitude: range(-122.5, -122.7))}
User.where(latitude: nil).each {|a| a.destroy}

User.create!(user_name: 'Admin', email: 'local@swap.app', address: '100 N Blandena Portland', password: 'password')

User.find_by(user_name: 'Admin').chat_rooms.create!(title: "Portland Area")

Category.all.each do |category|
  User.find_by(user_name: 'Admin').chat_rooms.create!(title: category.name)
end

50.times do
  cat_id = Category.all.first.id + rand(10)
  prod = Product.create!(name: Faker::Commerce.product_name, condition: rand(5), description: Faker::Hipster.paragraph(2, true, 4), category_id: cat_id, user_id: User.all.first.id + rand(8))
  cat = Category.find(cat_id)
  cat.update(products: cat.products.push(prod))
end

30.times do
  Review.create!(content: Faker::Hipster.sentence, user_id: range(User.all.first.id, User.all.last.id), author_id: range(User.all.first.id, User.all.last.id), rating: 1 + rand(5), votes: rand(10))
end
