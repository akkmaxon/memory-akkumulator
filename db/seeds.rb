# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
example_user = User.create(
  email: "user@example.com",
  password: "password",
  password_confirmation: "password")

100.times do |n|
  category_title = case n
    when 0..9 then "First category"
    when 10..19 then "Second category"
    when 20..29 then "Third category"
    when 30..39 then "Fourth category"
    when 40..49 then "Fifth category"
    when 50..59 then "Sixth category"
    when 60..69 then "Seventh category"
    when 70..79 then "Eighth category"
    when 80..89 then "Lost count category"
    when 90..99 then "Last category"
    end
  title = Faker::Lorem.sentence
  content = Faker::Lorem.paragraph
  category = Category.find_by(title: category_title) || Category.create(title: category_title)
  Article.create(
    title: title,
    content: content,
    user_id: example_user.id,
    category: category)
end
