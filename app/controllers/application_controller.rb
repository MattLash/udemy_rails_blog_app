class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  
  def current_user
    #return current_user if it already exists, if not (||=) then find the current user based on their :user_id
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    # the "!!" converts anything to a boolean, we are just checking if there is a current user here at all
    !!current_user
  end
  
  def require_user
    #check to see if user is logged in, or easier to check if "not logged in" -> !logged_in?
    if !logged_in?
      flash[:danger] =  "You must be logged in to make that happen!"
      redirect_to root_path
    end
  end
  
  def require_same_user
    if current_user != @article.user
      flash[:danger] = "That's not yours to edit, hands off!"
      redirect_to root_path
    end
  end
  
end
