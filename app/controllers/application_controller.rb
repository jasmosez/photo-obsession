class ApplicationController < ActionController::Base

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
        when "users#show"
            return user_path(instance)
        when "users#index"
            return users_path
        when "sessions#show"
            return dashboard_path
        end
    
    end

end
