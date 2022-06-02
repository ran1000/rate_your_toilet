# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

toiletphotos = ["Basic Toilet", "Comfy Toilet", "Regular Toilet"]
Toilet.destroy_all
Review.destroy_all

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
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude,
      user_id: @user[:id]
    )
    @toilet.save!



    @review = Review.new(
      comment: Faker::Quotes::Shakespeare.as_you_like_it_quote,
      rating: [1, 2, 3, 4, 5].sample,
      baby: [true, false].sample,
      accessible: [true, false].sample,
      sink: [true, false].sample,
      soap: [true, false].sample,
      paper: [true, false].sample,
      tampon: [true, false].sample,
      bin: [true, false].sample,
      hanger: [true, false].sample,
      spacious: [true, false].sample,
      clean: [true, false].sample,
      gendered: [true, false].sample,
      privacy: [true, false].sample,
      urinal: [true, false].sample,
      towel: [true, false].sample,
      gratis: [true, false].sample,
      user_id: @user[:id],
      toilet_id: @toilet[:id]
    )
    @review.photos.attach(io: File.open(Rails.root.join("app/assets/images/toilets/#{toiletphotos.sample}.jpeg")),
                  filename: 'toilet.jpeg')
    @review.save!

    @favorite = Favorite.new(
      user_id: @user[:id],
      toilet_id: @toilet[:id]
    )
    @favorite.save!
  end
end
