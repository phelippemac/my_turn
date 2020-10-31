class ApplicationController < ActionController::Base

  private 
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
      @today = Time.current.strftime('%d/%m/%Y').to_date
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
    dd = 0
    @dates = []
    @weekdays.each do |_day|
      if (@today + dd).saturday?
        dd += 2
      elsif (@today + dd).sunday?
        dd += 1
      end
      @dates << (@today + dd.days).strftime('%d/%m/%Y')
      dd += 1
    end
  end

end
