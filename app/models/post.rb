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
            like.user_id == current_user
        end
    end
end
