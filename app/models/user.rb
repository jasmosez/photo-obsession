class User < ApplicationRecord
    has_secure_password
    
    has_many :posts
    has_many :comments
    has_many :posts, through: :comments
    has_many :likes
    has_many :posts, through: :likes

    has_many :active_relationships, class_name: "Obsession", foreign_key: :fan_id, dependent: :destroy
    has_many :idols, through: :active_relationships, source: :idol
    has_many :passive_relationships, class_name: "Obsession", foreign_key: :idol_id, dependent: :destroy
    has_many :fans, through: :passive_relationships, source: :fan


    def my_authored_posts
        Post.all.select {|p| p.user_id == self.id}  
    end

    def my_idols_posts
        byebug
        posts = []
        self.idols.each do |idol|
            posts << idol.my_authored_posts
        end
        posts.flatten.sort {|a,b| b.created_at <=> a.created_at}
        # posts.uniq # to control for bad seed data in which a user idolizes another user more than once
    end


end
