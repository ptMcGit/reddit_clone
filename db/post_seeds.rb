post_titles = [
  {
    title: "Yes, Yes, YES..."
  },
  {
    title: "Ahoy mateys!"
  },
  {
    title: "where's all my peeps?"
  },
  {
    title: "Extra extra!"
  },
  {
    title: "Sabado gigante!"
  },
  {
    title: "Ding ding ding."
  }
]

post_content = [
  {
    content: "Tony Robbins is the best motivational speaker. If I had to do rehabilitative work I would definitely choose him over Richard Simmons."
  },
  {
    content: "The worst of the 'Best of the Best' films is definitely the first one. Sean Penn's brother gives a performance reminiscent of Julia Robert's brother in 'Runaway Train'."
  },
  {
    content: "Have you ever farted inside of an igloo?"
  },
  {
    content: "I have lots of opinions."
  },
  {
    content: "Country music is definitely making a comeback. I picked up a new pair of boots today and dug up my stone-washed jeans just yesterday."
  },
  {
    content: "You will are have my opinions. Buy, buy, buy."
  },
]
100.times do |post|
  Post.create!(
    title:      post_titles.sample[:title],
    content:    post_content.sample[:content],
    user_id:    User.all.sample.id,
    room_id:    Room.all.sample.id,
    created_at: Time.now
  )
end
