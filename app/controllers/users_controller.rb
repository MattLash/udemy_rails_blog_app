class UsersController < ApplicationController
    
    def new
        @user = User.new 
    end
    
    def create
    #   
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome, #{@user.username}, we've been waiting for you"
            redirect_to articles_path
        else
           flash[:danger] = "Let's try this again"
           render 'new'
        end
        
    end
    
    
    private
        def user_params
           params.require(:user).permit(:username, :email, :password)
            
        end
end
