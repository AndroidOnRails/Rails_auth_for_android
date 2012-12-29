class UsersController < ApplicationController

	skip_before_filter :verify_authenticity_token

	def index
		
	end

	def list_users
		@users = User.all
		respond_to do |format|
			format.html
			format.json {render :json => {:users => @users}}
			format.xml 	{render xml: {:users => @users}}
		end
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			render json: {:registration_success => @user}
		else
			render json: {:registration_failure => @user}
		end
	end

	def login
		@user = User.authenticate params[:user][:email], params[:user][:password]
		if @user
			render json: {:login_success => @user}
		else
			render json: {:login_failed => @user}
		end
	end
end