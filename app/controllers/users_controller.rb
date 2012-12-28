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
			respond_to do |format|
				# format.html
				format.json {render :json => {:success => @user}}
				format.xml {render :xml => @user}
			end
		else
			respond_to do |format|
				format.json {render :json => @user}
				format.xml {render :xml => @user}
			end
		end
	end

end