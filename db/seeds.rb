roles = ["developer", "designer"]
images = ["http://image005.flaticon.com/1/svg/14/14427.svg", "http://image005.flaticon.com/1/svg/29/29104.svg", "http://image005.flaticon.com/17/svg/56/56361.svg", "http://image005.flaticon.com/11/svg/9/9299.svg", "http://image005.flaticon.com/1/svg/29/29594.svg", "http://image005.flaticon.com/1/svg/71/71724.svg", "http://image005.flaticon.com/1/svg/35/35446.svg", "http://image005.flaticon.com/1/svg/68/68792.svg"]

40.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", role: roles.sample, img: "https://www.mautic.org/media/images/default_avatar.png")
end

20.times do
  Project.create!(title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, user_id: rand(1..30), img: images.sample)
end

10.times do
  Project.create!(title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, user_id: rand(30..40), expiration: Date.today, img: images.sample)
end

