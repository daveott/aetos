# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.create(name: 'fridge')
Product.create(name: 'ball')
Product.create(name: 'mouse')
Product.create(name: 'keyboard')
Product.create(name: 'lightsaber')
Product.create(name: 'oven mitt')
Product.create(name: 'ipod')
Product.create(name: 'tea pot')

product_ids = Product.all.pluck(:id)
200.times do
  Order.create(product_id: product_ids.sample, order_date: rand(1..365).days.ago.to_s)
end
