roles = ["developer", "designer"]

40.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", role: roles.sample)
end

20.times do
  Project.create!(title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, user_id: rand(1..30))
end

10.times do
  Project.create!(title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, user_id: rand(30..40), expiration: Date.today)
end

