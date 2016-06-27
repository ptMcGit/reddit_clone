[
  {
    email: "admin@admin",
    password: "password"
  },
  {
    email: "admin2@admin",
    password: "password"
  }
].each do |user|
  u = User.create!(
    email: user[:email],
    password: user[:password]
  )
  Admin.create!(
    user_id: u.id
  )
end
