class EventsController < ApplicationController

before_action :authenticate_user!
before_action :confirmed, only: [:new, :create, :edit, :update, :destroy]

require 'will_paginate/array'

  def index
    if params[:search].present?
      @city = params[:search]
      #filter events  
      @events = Event.near(@city, 100)
      if params[:date_filter]
        date_filter = params[:date_filter]
        @date = Date.new date_filter["(1i)"].to_i, date_filter["(2i)"].to_i, date_filter["(3i)"].to_i rescue nil
        @events = Event.where('(date = ? AND enddate IS NULL) OR (date <= ? AND enddate >= ?) OR (date IS NULL AND enddate IS NULL) OR (date IS NULL AND enddate >= ?)', 
            @date, @date, @date, @date)
        @events = @events.flat_map{ |e| e.calender(@date) }
      else
        @events = Event.where('(date = ? AND enddate IS NULL) OR (date <= ? AND enddate >= ?) OR (date IS NULL AND enddate IS NULL) OR (date IS NULL AND enddate >= ?)', 
            Date.today, Date.today, Date.today, Date.today).near(@city, 100)
        @events = @events.flat_map{ |e| e.calender(Time.now.to_date) }
      end
      @events = @events.select{|event| event.category == params[:with_category]} unless params[:with_category].blank?

    else
      @city = current_user.city
      #filter events  
      @events = Event.near(@city, 100)
      if params[:date_filter]
        date_filter = params[:date_filter]
        @date = Date.new date_filter["(1i)"].to_i, date_filter["(2i)"].to_i, date_filter["(3i)"].to_i rescue nil
        @events = Event.where('(date = ? AND enddate IS NULL) OR (date <= ? AND enddate >= ?) OR (date IS NULL AND enddate IS NULL) OR (date IS NULL AND enddate >= ?)', 
            @date, @date, @date, @date)
        @events = @events.flat_map{ |e| e.calender(@date) }
      else
        @events = Event.where('(date = ? AND enddate IS NULL) OR (date <= ? AND enddate >= ?) OR (date IS NULL AND enddate IS NULL) OR (date IS NULL AND enddate >= ?)', 
            Date.today, Date.today, Date.today, Date.today).near(@city, 100)
        @events = @events.flat_map{ |e| e.calender(Time.now.to_date) }
      end
      @events = @events.select{|event| event.category == params[:with_category]} unless params[:with_category].blank?
    end
     #paginate results
      @events = @events.paginate(page: params[:page], per_page: 10)
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

  def confirmed
    if !current_user.confirmed?
      flash[:alert] = "Please verify your email."
      flash.keep
      redirect_to root_path
   end
  end

  def event_params
    params.require(:event).permit(:title, :description, :cover_image, 
      :category, :url, :date, :enddate, 
      :address, :hour, :minute, :meridiem,
      :endhour, :endminute, :endmeridiem, :recurring)
  end
end
