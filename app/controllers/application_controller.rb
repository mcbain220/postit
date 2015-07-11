class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?  #this makes these methods available to the view templates

  def current_user
  	@current_user ||=	User.find(session[:user_id]) if session[:user_id]
  	# ||= is called "memoizartion" and is used for optimization purposes - it says..if this instance variable
  	# exists...do not run this code.  Only run it if it does not exist...for every time you call current_user method.
  	# this only happens within one template
  end

  def logged_in?
  	!!current_user   #this turns this method into a boolean..so nil will not be returned.
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to root_path
    end
  end
   

end
