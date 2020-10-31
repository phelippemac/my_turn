class HomeController < ApplicationController
 
  before_action :authenticate_user!, except: :index
  
  def index; end

  def system
    super
  end

  def link
    @date = params[:date_to]
    @hour = params[:hour_to]
    if @date.to_date.past?
      @partial = 'partials/failed'
    else
      @partial = 'partials/form'
    end

    respond_to do |format|
      format.js
    end
  end

  def edit
    @res = Appointment.find(params[:id])
    @date = @res.day
    @hour = @res.hour
    @duration = @res.duration
    @description = @res.description
    respond_to do |format|
      format.js
    end
  end

  def view
    @res = Appointment.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
end
