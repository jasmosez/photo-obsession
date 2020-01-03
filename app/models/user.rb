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

    def sort_authored_posts
        authored_posts = self.my_authored_posts
        authored_posts.sort { |a, b| b.created_at <=> a.created_at }
    end

    def my_idols_posts
        posts = []
        self.idols.each do |idol|
            posts << idol.my_authored_posts
        end
        posts.flatten.sort {|a,b| b.created_at <=> a.created_at}
        # posts.uniq # to control for bad seed data in which a user idolizes another user more than once
    end

    def total_likes 
        total_likes = []
        self.my_authored_posts.each do |p| 
            total_likes << p.likes.count 
        end
        total_likes.sum
    end

    def total_posts 
        self.my_authored_posts.count
    end

    def most_liked_post
        most_liked_post = self.my_authored_posts.max do |a, b| 
            a.likes.length <=> b.likes.length 
        end 
    end

    def most_commented_post 
        most_commented_post = self.my_authored_posts.max do |a, b|
            a.comments.length <=> b.comments.length
        end
    end 

    # def common_idols
    #     results = []
    #     #byebug
    #     User.all.each do |u|
    #         u.idols.each do |i| 
    #             if self.idols.find(i.id)
    #                 results << i
    #             end
    #         end
    #     end
    #     results
    # end 

end
