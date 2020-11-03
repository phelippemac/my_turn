class Setting < ApplicationRecord

  def interval_s
    case interval
    when 1.0
      'Horas cheias (EX: 10:00, 15:00)'
    when 0.5
      'Horas quebradas (EX: 10:30, 15:00, 15:30)'
    end
  end

  def max_usage_s
    case max_usage
    when 1.0
      'A reserva pode ser feita por no máximo uma hora'
    when 2.0
      'A reserva pode ser feita por no máximo duas horaa'
    when 3.0
      'A reserva pode ser feita por no máximo três horas'
    end
  end

  def period
    "#{parse_time(initial_period)} às #{parse_time(last_period)}"
  end

  def parse_time(num)
    num = num.to_i
    if num < 10
      "0#{num}:00"
    else
      "#{num}:00"
    end
  end
end
