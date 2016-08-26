count   = 0
total   = Room.count * 100
users   = Array(User.all.shuffle)
posts   = Array(Post.all.shuffle)

loop do
  Comment.create!(
    content:    Faker::Lorem.sentence,
    user_id:    users.rotate!.first.id,
    post_id:    posts.rotate!.first.id
  )
  count += 1
  break if count == total
end
