class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]
    
    def index
       @users = User.paginate(page: params[:page], per_page: 5) 
    end
    
    def new
        @user = User.new 
    end
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Welcome, #{@user.username}, we've been waiting for you"
            redirect_to user_path(@user)
        else
           flash[:danger] = "Let's try this again"
           render 'new'
        end
    end
    def edit
        # @user = User.find(params[:id])  -- don't need anymore, as we're using before_action :set_user
    end
    def update
        # @user = User.find(params[:id]) -- don't need anymore, as we're using before_action :set_user
        if @user.update(user_params)
            flash[:success] = "Updated successfully"
            redirect_to articles_path
        else
           render 'edit' 
        end
    end
    def show
        # @user = User.find(params[:id]) -- don't need anymore, as we're using before_action :set_user
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = "This user and all it's article's have been deleted!"
        redirect_to users_path
    end
    
    private
        def user_params
           params.require(:user).permit(:username, :email, :password)
            
        end
        
        def set_user
            @user = User.find(params[:id])
        end
        def require_same_user
            if current_user != @user and !current_user.admin?
                flash[:danger] = "You cannot edit this account, step back!"
                redirect_to root_path
            end
        end
        def require_admin
           if logged_in? and !current_user.admin?
               flash[:danger] = "only admin users can do this"
               redirect_to root_path
           end
        end
end
