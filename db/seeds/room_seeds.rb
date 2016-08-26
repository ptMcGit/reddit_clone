def create_moderator_user room_name
  User.create!(
    username:   room_name.sub(/([^ ]+)([ ]+)([^ ]+)([ ]|$)/, '\1admin').downcase,
    email:      room_name.sub(/([^ ]+)([ ]+)([^ ]+)([ ]|$)/, '\1@\3').downcase,
    password:   "password"
  )
end

[
  {
  name: "Advanced Buzzardry",
  description: "Avian acumen and avid ornithological anthems."
  },
  {
  name: "Riparian Revelry",
  description: "Herpetological high socks and and hand-wear."
  },
  {
    name: "Brand X",
    description: "A discussion of our favorite brand, Brand X."
  },
  {
    name: "Wildebeast Hunting",
    description: "Answer the call of the wilde."
  },
  {
    name: "Ask Methuselah",
    description: "Wisdom and other wares."
  }
].each do |room|
  # create a user to be assigned as moderator
  mod =  create_moderator_user(room[:name])
  # create room, and callback results in new moderator
  Room.create!(
    name: room[:name],
    description: room[:description],
    user_id: mod.id
  )
end
