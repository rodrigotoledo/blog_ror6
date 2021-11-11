require 'faker'
20.times.each do
  Post.create!(title: Faker::Book.title, content: Faker::Lorem.paragraph)
end