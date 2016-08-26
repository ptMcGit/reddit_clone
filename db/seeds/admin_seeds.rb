include FactoryGirl::Syntax::Methods

[
  {
    username:   "admin1",
    email:      "admin@example.com",
    password:   "password"
  },
  {
    username:   "admin2",
    email:      "admin2@example.com",
    password:   "password"
  }
].each do |user|
  u = create :user,
         {
           username:    user[:username],
           email:       user[:email],
           password:    user[:password]
         }
  Admin.create!(
    user_id: u.id
  )
end
