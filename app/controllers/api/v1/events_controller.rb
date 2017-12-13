class Api::V1::EventsController < ApplicationController

def get_events
	@city = params[:city]
	@events = Event.near(@city, 100)
	@date = params[:today]
	@events = Event.where('(date = ? AND enddate IS NULL) OR (date <= ? AND enddate >= ?) OR (date IS NULL AND enddate IS NULL) OR (date IS NULL AND enddate >= ?)', 
	      @date, @date, @date, @date)
	@events = @events.flat_map{ |e| e.calender(@date) }
	render json: {
		events: @events
	}
end

def show
	@event = Event.find_by(id: param[:id])
	render json: {
		event: @event
	}
end

def profile
	@user = current_user
	@city = @user.city
	@name = @user.name
	@posts = current_user.events.order('created_at DESC').paginate(page: params[:page], per_page: 10)
end

end