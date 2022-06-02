# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

2.times do
  @user = User.new(
    username: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: "123456"
  )
  @user.save!
  3.times do
    @toilet = Toilet.new(
      name: Faker::Restaurant.name,
      address: Faker::Address.full_address,
      user_id: @user[:id]
    )
    @toilet.save!
    1.times do
      @favorite = Favorite.new(
        user_id: @user[:id],
        toilet_id: @toilet[:id]
      )
      @favorite.save!
    end
  end
end
