class Post < ApplicationRecord
    belongs_to :user
    has_many :comments
    has_many :users, through: :comments
    has_many :likes
    has_many :users, through: :likes

    def total_likes
        self.likes.count
    end 

    def like?(current_user)
        self.likes.find do |like|
            like.user_id == current_user.id
        end
    end

    def self.sort_options
        ["Recent", "Most Liked", "Most Commented", "Random"]
    end

    def self.sort_index(sort_choice)
        case sort_choice
        when "Recent"
            self.all.sort { |a, b| b.created_at <=> a.created_at }
        when "Most Liked"
            self.all.sort { |a, b| b.likes.length <=> a.likes.length }
        when "Most Commented"
            self.all.sort { |a, b| b.comments.length <=> a.comments.length }
        when "Random"
            self.all.shuffle
        end   
    end

end
