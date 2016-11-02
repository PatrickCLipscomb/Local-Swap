# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.all.each {|c| c.destroy}
Product.all.each {|p| p.destroy}
User.all.each {|u| u.destroy}
Review.all.each {|r| r.destroy}

10.times do
  Category.create(name: Faker::Commerce.department)
end

8.times do
  User.create(user_name: Faker::Name.name, email: Faker::Internet.email, address: Faker::Address.street_address, password: 'password')
end

def range (min, max)
  rand * (max-min) + min
end

User.all.each {|a| a.update(bio: Faker::Hipster.paragraph, latitude: range(45.4, 45.6), longitude: range(-122.5, -122.7))}
User.where(latitude: nil).each {|a| a.destroy}

50.times do
  cat_id = Category.all.first.id + rand(10)
  prod = Product.create(name: Faker::Commerce.product_name, price: rand(50), description: Faker::Hipster.paragraph(2, true, 4), category_id: cat_id, user_id: User.all.first.id + rand(8), image: Faker::Avatar.image)
  cat = Category.find(cat_id)
  cat.update(products: cat.products.push(prod))
end

30.times do
  Review.create(content: Faker::Hipster.sentence, user_id: range(User.all.first.id, User.all.last.id), author_id: range(User.all.first.id, User.all.last.id), rating: 1 + rand(5), votes: rand(10))
end

User.create(user_name: 'Admin', email: 'local@swap.app', address: '100 N Blandena Portland', password: 'password')
