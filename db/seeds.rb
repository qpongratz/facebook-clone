# frozen_string_literal: true

puts 'Seeding Database'

PASSWORD = '123456'

puts 'Seeding users...'
test = User.new(first_name: 'Test',
                last_name: 'Test',
                email: 'test@test.com',
                password: PASSWORD,
                password_confirmation: PASSWORD)
test.save
test = User.first

20.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.unique.email
  user.password = PASSWORD
  user.password_confirmation = PASSWORD
  user.save
end

puts 'Seeding posts...'

all_users = User.all

all_users.each do |user|
  3.times do
    post = Post.new
    post.content = Faker::Movies::HitchhikersGuideToTheGalaxy.quote
    post.user_id = user.id
    post.save
  end
end

puts 'Seeding friendships...'

all_users.each do |user|
  next if user.id == 1

  user.outgoing_friendships.create(friend_id: test.id)
end

puts 'Seeding Complete'
