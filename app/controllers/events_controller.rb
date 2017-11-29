class EventsController < ApplicationController

before_action :authenticate_user!

require 'will_paginate/array'

  def index
    if params[:search].present?
      @events = Event.near(params[:search], 100)
      @events_near = Event.where('(date = ? AND enddate IS NULL) OR (date <= ? AND enddate >= ?) OR (date IS NULL AND enddate IS NULL) OR (date IS NULL AND enddate >= ?)', 
        Date.today, Date.today, Date.today, Date.today).near(params[:search], 100)
      @events = @events_near.flat_map{ |e| e.today(params.fetch(:date, Time.now).to_date) }
      @events = @events.paginate(page: params[:page], per_page: 10)
    else
      @city = current_user.city
      @events_near = Event.where('(date = ? AND enddate IS NULL) OR (date <= ? AND enddate >= ?) OR (date IS NULL AND enddate IS NULL) OR (date IS NULL AND enddate >= ?)', 
         Date.today, Date.today, Date.today, Date.today).near(@city, 100)
      @events = @events_near.flat_map{ |e| e.today(params.fetch(:date, Time.now).to_date) }
      @events = @events.paginate(page: params[:page], per_page: 10)
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
       redirect_to event_path(@event.id)
       flash[:notice] = "Event successfully created."
    else
      render 'new' 
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if current_user = @event.user
      @event.destroy
      flash[:notice] = "Event successfully deleted."
    end
      redirect_to profile_path
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if !params[:event].has_key?(:enddate)
        @event.enddate = nil
    end

    if !params[:event].has_key?(:date)
        @event.date = nil
    end

    if current_user = @event.user
      if @event.update(event_params)
        redirect_to event_path(@event.id)
        flash[:notice] = "Changes saved successfully."
      else
        render 'edit'
      end
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  private 

  def event_params
    params.require(:event).permit(:title, :description, :cover_image, 
      :category, :url, :date, :enddate, 
      :address, :hour, :minute, :meridiem,
      :endhour, :endminute, :endmeridiem, :recurring)
  end

end
