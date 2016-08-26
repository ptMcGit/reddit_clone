count   = 0
total   = Room.count * 100
users   = Array(User.all.shuffle)
posts   = Array(Post.all.shuffle)

loop do
  Vote.create!(
    user_id:    users.rotate!.first.id,
    post_id:    posts.rotate!.first.id,
    value:      [1, -1].sample
  )
  count += 1
  break if count == total
end
