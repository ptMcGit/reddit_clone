# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



require_relative './users'

Users.each do |user|
  User.create!(
    name: user[:name],
    email: user[:email],
    password: user[:password],
    created_at: Time.now
  )
end

require_relative './rooms'

Rooms.each do |room|
  Room.create!(
    name: room[:name],
    description: room[:description],
    created_at: Time.now
  )
end

1000.times do |vote|
  Vote.create!(
    message_id: Message.all.sample.id,
    value: [-1,1].sample,
    created_at: Time.now
  )
end

require_relative './posts'

100.times do |post|
  Post.create!(
    content: Posts.sample[:content],
    user_id: User.all.sample.id,
    room_id: Room.all.sample.id,
    created_at: Time.now
  )
end

require_relative './messages'

Messages.each do |message|
  Message.create!(
    user_id: User.all.sample.id,
    content: message[:content],
    created_at: Time.now,
    post_id: Post.all.sample.id
  )
end
