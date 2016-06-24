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
  Room.create!(
    name: room[:name],
    description: room[:description],
    created_at: Time.now
  )
end
