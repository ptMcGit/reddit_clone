count   = 0
total   = Post.count * 10
users   = Array(User.all.shuffle)
posts   = Array(Post.all.shuffle)

loop do
  Comment.create!(
    content:            Faker::Lorem.sentence,
    user_id:            users.rotate!.first.id,
    commentable_id:     posts.rotate!.first.id,
    commentable_type:   "Post"
  )
  count += 1
  break if count == total
end
