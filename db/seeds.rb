roles = ["developer", "designer"]
avatars = ["http://s33.postimg.org/bxh2ye0qn/av1.png", "http://s33.postimg.org/i28lbpsu7/av2.png", "http://s33.postimg.org/t5s7hbe4f/av3.png", "http://s33.postimg.org/wvn8wh0lb/av4.png", "http://s33.postimg.org/5qaabyudb/av5.png", "http://s33.postimg.org/usctot0sf/av6.png", "http://s33.postimg.org/yen8f6wjj/av7.png", "http://s33.postimg.org/nvn8q0tvj/av8.png", "http://s33.postimg.org/66vhyei4f/av9.png", "http://s33.postimg.org/8ph6z33un/av10.png", "http://s33.postimg.org/jdkxxxdtr/av11.png", "http://s33.postimg.org/b9ctt6ren/av12.png" ]
images = ["http://image005.flaticon.com/1/svg/59/59118.svg", "http://image005.flaticon.com/1/svg/59/59505.svg", "http://image005.flaticon.com/1/svg/14/14427.svg", "http://image005.flaticon.com/1/svg/29/29104.svg", "http://image005.flaticon.com/17/svg/56/56361.svg", "http://image005.flaticon.com/11/svg/9/9299.svg", "http://image005.flaticon.com/1/svg/29/29594.svg", "http://image005.flaticon.com/1/svg/71/71724.svg", "http://image005.flaticon.com/1/svg/35/35446.svg", "http://image005.flaticon.com/1/svg/21/21520.svg", "http://image005.flaticon.com/1/svg/68/68792.svg"]

  40.times do
    User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", role: roles.sample, img: avatars.sample)
  end

20.times do
  Project.create!(title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, user_id: rand(1..30), img: images.sample)
end

10.times do
  Project.create!(title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, user_id: rand(30..40), expiration: Date.today, img: images.sample)
end

