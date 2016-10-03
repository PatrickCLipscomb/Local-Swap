# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  Category.create(name: Faker::Commerce.department)
end
#
8.times do
  User.create(user_name: Faker::Name.name, email: Faker::Internet.email, address: Faker::Address.street_address, password: 'password')
end



User.where(latitude: nil).each {|a| a.destroy}

50.times do
  cat_id = Category.all.first.id + rand(10)
  prod = Product.create(name: Faker::Commerce.product_name, price: rand(50), category_id: cat_id, user_id: User.all.first.id + rand(8))
  cat = Category.find(cat_id)
  cat.update(products: cat.products.push(prod))
end
#
# 100.times do
#   Review.create(name: Faker::Commerce.color, content: Faker::Company.catch_phrase, rating: rand(5), product_id: rand(50))
# end
