# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Sweeping seeds'

Toilet.destroy_all
User.destroy_all
Review.destroy_all
Favorite.destroy_all

puts 'DB emptied'

puts 'Creating users...'

2.times do
  @user = User.new(
    username: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: "123456"
  )
  @user.save!

  puts "Created user #{User.last.id}"

  3.times do
    @toilet = Toilet.new(
      name: Faker::Restaurant.name,
      address: Toilet::RESTAURANTS_ADDRESSES.sample,
      user_id: @user[:id]
    )
    @toilet.save!

    puts "Created toilet #{Toilet.last.id}"

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
    @review.photos.attach(io: File.open(Rails.root.join("app/assets/images/toilets/#{Toilet::TOILETPHOTOS.sample}.jpeg")),
    filename: 'toilet.jpeg')
    @review.save!

    puts "Created review #{Review.last.id}"

    puts 'Creating favorites...'

    @favorite = Favorite.new(
      user_id: @user[:id],
      toilet_id: @toilet[:id]
    )
    @favorite.save!
  end
end

puts "created #{Toilet.count} toilets"
puts "created #{Review.count} reviews"
puts "created #{User.count} users"
puts "favorites generated"
