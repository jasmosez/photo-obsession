require 'RestClient'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# HELPERS
def user_data
    u1 = User.create(username: "Maddy", password: "123", bio: Faker::GreekPhilosophers.quote, avatar: Faker::Avatar.image)
    u2 = User.create(username: "James", password: "123", bio: Faker::GreekPhilosophers.quote, avatar: Faker::Avatar.image)
    u3 = User.create(username: "Tim", password: "123", bio: Faker::GreekPhilosophers.quote, avatar: Faker::Avatar.image)
    u4 = User.create(username: "Kevin", password: "123", bio: Faker::GreekPhilosophers.quote, avatar: Faker::Avatar.image)
    u5 = User.create(username: "Alex", password: "123", bio: Faker::GreekPhilosophers.quote, avatar: Faker::Avatar.image)

    Post.create(img_url: "https://ca.slack-edge.com/T02MD9XTF-UQ32TAFUJ-8dc8eda88489-512", user_id: u1.id, caption: Faker::Movies::Lebowski.quote)
    Post.create(img_url: "https://ca.slack-edge.com/T02MD9XTF-UQJ2R94EA-0d4d26671dd9-512", user_id: u2.id, caption: Faker::Movies::Lebowski.quote)
    Post.create(img_url: "https://ca.slack-edge.com/T02MD9XTF-UNX1T44NQ-347b781241f1-512", user_id: u3.id, caption: Faker::Movies::Lebowski.quote)
    Post.create(img_url: "https://ca.slack-edge.com/T02MD9XTF-UPMCZ4DA9-97cc68f2f97d-512", user_id: u4.id, caption: Faker::Movies::Lebowski.quote)
    Post.create(img_url: "https://ca.slack-edge.com/T02MD9XTF-UQ32T8ZGA-1d8b246a8aff-512", user_id: u5.id, caption: Faker::Movies::Lebowski.quote)

    45.times do
        User.create(username: Faker::Name.unique.first_name, password: "123", bio: Faker::GreekPhilosophers.quote, avatar: Faker::Avatar.unique.image)
    end
end


def post_data
    url = "https://picsum.photos/450"

    200.times do
        response = RestClient.get(url)    
        id = response.headers[:picsum_id]
        
        # parse response string into parsed_string
        parsed_url = "https://i.picsum.photos/id/#{id}/450/450.jpg"

        Post.create(img_url: parsed_url, user_id: User.all.sample.id, caption: Faker::Movies::Lebowski.quote)
    end

end

def comment_data
    500.times do
        Comment.create(user_id: User.all.sample.id, post_id: Post.all.sample.id, content: Faker::TvShows::MichaelScott.quote)
    end
end

def like_data
    likes = []
    500.times do
        likes << Like.new(user_id: User.all.sample.id, post_id: Post.all.sample.id)
    end 
    likes.each do |like|
        if !Like.find_by(user_id: like.user_id, post_id: like.post_id)
            like.save
        end
    end
end


def obession_data
    obs = []
    250.times do
        fan = User.all.sample.id
        idol = User.all.sample.id 
        obs << Obsession.new(fan_id: fan, idol_id: idol) if fan != idol
    end
    obs.each do |obs|
        if !Obsession.find_by(fan_id: obs.fan_id, idol_id: obs.idol_id)
            obs.save
        end
    end
    
end


# DESTROY
Obsession.destroy_all
Like.destroy_all
Comment.destroy_all
Post.destroy_all
User.destroy_all

# ACTUAL SEEDING
user_data
post_data
comment_data
like_data
obession_data


