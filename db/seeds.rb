# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require_relative './user_seeds'
require_relative './room_seeds'
require_relative './post_seeds'

messages = [
  {
    content: "I completely disagree."
  },
  {
    content: "What is a Sheboygan?"
  },
  {
    content: "Half the time it's a square."
  },
  {
    content: "My legs disagree."
  },
  {
    content: "I a bear attacks a mime in the woods..."
  },
  {
    content: "Now that's a fine apiary."
  }
]

Room.all.each do |room|
  room.posts.each do |post|
    rand(10).times do
      m = Message.create!(
        user_id: User.all.sample.id,
        content: messages.sample[:content],
        created_at: Time.now,
        post_id: post.id
      )
      rand(10).times do |vote|
        Vote.create!(
          user_id: User.all.sample.id,
          message_id: m.id,
          value: [1,-1].sample
        )
      end
    end
  end
end
