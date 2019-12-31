
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Obsession.destroy_all
Like.destroy_all
Comment.destroy_all
Post.destroy_all
User.destroy_all

u1 = User.create(username: "Maddy", password: "123")
u2 = User.create(username: "James", password: "123")
u3 = User.create(username: "Tim", password: "123")
u4 = User.create(username: "Kevin", password: "123")
u5 = User.create(username: "Alex", password: "123")

Post.create(img_url: "https://ca.slack-edge.com/T02MD9XTF-UQ32TAFUJ-8dc8eda88489-512", user_id: u1.id)
Post.create(img_url: "https://ca.slack-edge.com/T02MD9XTF-UQJ2R94EA-0d4d26671dd9-512", user_id: u2.id)
Post.create(img_url: "https://ca.slack-edge.com/T02MD9XTF-UNX1T44NQ-347b781241f1-512", user_id: u3.id)
Post.create(img_url: "https://ca.slack-edge.com/T02MD9XTF-UPMCZ4DA9-97cc68f2f97d-512", user_id: u4.id)
Post.create(img_url: "https://ca.slack-edge.com/T02MD9XTF-UQ32T8ZGA-1d8b246a8aff-512", user_id: u5.id)

byebug

Comment.create(user_id: User.all.sample.id, post_id: Post.all.sample.id, content: "Wow!")
Comment.create(user_id: User.all.sample.id, post_id: Post.all.sample.id, content: "Neat!")
Comment.create(user_id: User.all.sample.id, post_id: Post.all.sample.id, content: "Ew!")
Comment.create(user_id: User.all.sample.id, post_id: Post.all.sample.id, content: "Great pic!")
Comment.create(user_id: User.all.sample.id, post_id: Post.all.sample.id, content: "Nice!")

10.times do
    Like.create(user_id: User.all.sample.id, post_id: Post.all.sample.id)
end 

10.times do
    fan = User.all.sample.id
    idol = User.all.sample.id
    Obsession.create(fan_id: fan, idol_id: idol) if fan != idol
end

