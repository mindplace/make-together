roles = ["developer", "designer"]
avatars = ["http://s33.postimg.org/bxh2ye0qn/av1.png", "http://s33.postimg.org/i28lbpsu7/av2.png", "http://s33.postimg.org/t5s7hbe4f/av3.png", "http://s33.postimg.org/wvn8wh0lb/av4.png", "http://s33.postimg.org/5qaabyudb/av5.png", "http://s33.postimg.org/usctot0sf/av6.png", "http://s33.postimg.org/yen8f6wjj/av7.png", "http://s33.postimg.org/nvn8q0tvj/av8.png", "http://s33.postimg.org/66vhyei4f/av9.png", "http://s33.postimg.org/8ph6z33un/av10.png", "http://s33.postimg.org/jdkxxxdtr/av11.png", "http://s33.postimg.org/b9ctt6ren/av12.png" ]

  40.times do
    User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", role: roles.sample, img: avatars.sample)
  end

40.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", role: roles.sample)
end

20.times do
  Project.create!(title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, user_id: rand(1..30))
end

10.times do
  Project.create!(title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, user_id: rand(30..40), expiration: Date.today)
end

