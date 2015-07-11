class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.find_by(username: params[:username])

		 if user && user.authenticate(params[:password])
		 	session[:user_id] = user.id   # this saves to a cookie - dont save user object because of size limit.
		 	flash[:notice] = "Welcome, you've logged in."
		 	redirect_to root_path
		 else
		 	flash[:error] = "Something is wrong with your username or password."
		 	redirect_to login_path :new
		 end

	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You have successfully logged out."
		redirect_to root_path
	end


end

