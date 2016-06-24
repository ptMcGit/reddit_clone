[
  {
  email: "pw@pw.com",
  password: "password",
  },
  {
  email: "aw@aw.com",
  password: "password",
  },
  {
  email: "gw@gw.com",
  password: "password",
  }
].each do |user|
  User.create!(
    email: user[:email],
    password: user[:password],
    created_at: Time.now
  )
end
