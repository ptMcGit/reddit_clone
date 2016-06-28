# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require_relative './user_seeds'
require_relative './admin_seeds'
require_relative './room_seeds'
require_relative './post_seeds'
require_relative './comment_seeds'

def random_votes total_to_provide
  ups = rand(total_to_provide)
  downs = total_to_provide - ups
  [-1] * downs +
    [1] * ups
end

Room.all.each do |room|

  # create some posts

  room.posts.each do |post|
    rand(10).times do
      m = Comment.create!(
        user_id: User.all.sample.id,
        content: random_comment,
        created_at: Time.now,
        post_id: post.id
      )

      # cast some votes

      votes_to_cast = random_votes(10)
      votes_to_cast.length.times do |vote|
        Vote.create!(
          user_id: User.all.sample.id,
          post_id: post.id,
          value: votes_to_cast.shift
        )
      end
    end
  end
end
