
count   = 0
total   = Room.count * 10
users   = Array(User.all.shuffle)
rooms   = Array(Room.all.shuffle)

loop do
  Post.create!(
    title:      Faker::Hipster.sentence,
    content:    Faker::Hipster.paragraph,
    user_id:    users.rotate!.first.id,
    room_id:    rooms.rotate!.first.id
  )
  count += 1
  break if count == total
end
