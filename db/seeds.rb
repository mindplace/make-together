5.times do
  Project.create!(title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph)
end