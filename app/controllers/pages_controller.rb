class PagesController < ApplicationController

	before_action :authenticate_user!, only:[:profile]

	def profile
		@city = request.location.city
		@events = current_user.events.order('created_at DESC').paginate(page: params[:page], per_page: 10)
	end

	def privacy
		render 'pages/privacy'
	end

	def terms
		render 'pages/tos'
	end

end