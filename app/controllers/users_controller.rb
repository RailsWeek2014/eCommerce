class UsersController < ApplicationController

	def index
		@users = User.all
		 render :layout => false
	end


	def edit_user
		@user = User.find(params[:id])
	end

	def show_all_user
		@users=User.all
		render :layout => false
	end


	def update_user
		user = User.find(params[:id])
		test=user.update_attributes(user_params)
		redirect_to dash_board_path
	end


	private 
	
	def user_params
		params.require(:user).permit(:email,:encrypted_password,:reset_password_token)
	end

end
