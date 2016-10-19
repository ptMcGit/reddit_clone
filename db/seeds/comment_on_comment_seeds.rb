count   = 0
total   = Comment.count * 20
users   = Array(User.all.shuffle)
comments   = Array(Comment.all)

until count == total
  (1..10).to_a.sample.times do
    comments.push Comment.create!(
                    content:            Faker::Lorem.sentence,
                    user_id:            users.rotate!.first.id,
                    commentable_id:     comments.sample.id,
                    commentable_type:   "Comment"
                  )

    count += 1
  end
end
