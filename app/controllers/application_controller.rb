class ApplicationController < ActionController::Base
    
    before_action :require_login , :set_nav_variables
    
    def set_nav_variables
        @current_user = current_user
    end

    def current_user
        User.find(session[:user_id])
    end

    # def last_view
    #     session[:last_view]
    # end

    def redirect_helper
        if !!session[:last_view_id]
            instance = session[:last_view_id]
        end
        
        case session[:last_view]
        when "posts#index" 
            return posts_path
        when "posts#show"
            return post_path(instance)
        
        when "users#index"
            return users_path
        when "users#show"
            return user_path(instance)
        when "users#obsessions"
            return obsessions_path(instance)
        
        when "sessions#show"
            return dashboard_path
        end
    
    end

    private

    def require_login
        return head(:forbidden) unless session.include? :user_id
    end

end
