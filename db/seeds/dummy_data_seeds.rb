include FactoryGirl::Syntax::Methods

seeds_dir = './db/seeds/'

# create admins
require "#{seeds_dir}admin_seeds.rb" if Rails.env != "production"

# test user
create :user, { username: "test", email: "test@example.com", password: "password" }

# create the default rooms
require "#{seeds_dir}/room_seeds.rb"

# create users
count = 0

loop do
  user = FactoryGirl.build :user
  if user.save
    count += 1
  end
  break if count == 20
end

# create posts
require "#{seeds_dir}/post_seeds.rb"

# create comments
require "#{seeds_dir}/comment_seeds.rb"

# create user votes
require "#{seeds_dir}/vote_seeds.rb"
