class PagesController < ApplicationController

	before_action :authenticate_user!, only:[:profile]

	def profile
		@user = current_user
		@city = @user.city
		@name = @user.name
		@events = current_user.events.order('created_at DESC').paginate(page: params[:page], per_page: 10)
	end

	def privacy
		render 'pages/privacy'
	end

	def terms
		render 'pages/terms'
	end

	def confirmed
		render 'pages/confirmed'
	end

end