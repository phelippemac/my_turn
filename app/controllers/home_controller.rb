class HomeController < ApplicationController
 
  before_action :authenticate_user!, except: :index
  
  def index; end

  def system
    user = current_user
    @name = user.name
    user.root? ? @type = 0 : @type = 1

    config = Setting.last
    @max = config.max_usage
    @interval = config.interval.to_f
    @initial_period = config.initial_period.to_f
    @last_period = config.last_period.to_f
    @weekdays = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta"]
    @reservations = Appointment.all
   
    if params[:new_day].present? && ! params[:new_day].blank?
      @today = params[:new_day].to_date
    else
      @today = Time.now
    end
    
    if @today.monday? || @today.sunday? || @today.saturday?
      rotate = 0
    elsif @today.tuesday?
      rotate = 1
    elsif @today.wednesday?
      rotate = 2
    elsif @today.thursday?
      rotate = 3
    elsif @today.friday?
      rotate = 4
    end
    rotate.times do
      @weekdays << @weekdays.shift
    end
    @period = []
    i = @initial_period
    while i <= @last_period
      i - i.to_i == 0 ? f = "00" :  f = "30"
      if i < 10
        @period << "0#{i.to_i}:#{f}"
      else
        @period << "#{i.to_i}:#{f}"
      end
      i += @interval
    end
  end

  def link
    @date = params[:date_to]
    @hour = params[:hour_to]
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

  def create_appoitment_alias
    respond_to do |format|
      format.js
    end
  end

  def delete_appoitment_alias
    respond_to do |format|
      format.js
    end
  end
end
