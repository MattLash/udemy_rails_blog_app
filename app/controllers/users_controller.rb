class UsersController < ApplicationController
    
    def index
       @users = User.paginate(page: params[:page], per_page: 5) 
    end
    
    def new
        @user = User.new 
    end
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome, #{@user.username}, we've been waiting for you"
            redirect_to articles_path
        else
           flash[:danger] = "Let's try this again"
           render 'new'
        end
    end
    def edit
        @user = User.find(params[:id])
    end
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "Updated successfully"
            redirect_to articles_path
        else
           render 'edit' 
        end
    end
    def show
        @user = User.find(params[:id])
    end
    
    private
        def user_params
           params.require(:user).permit(:username, :email, :password)
            
        end
end
