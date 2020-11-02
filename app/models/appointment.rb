class Appointment < ApplicationRecord
  belongs_to :user

  attr_accessor :current_user

  validates_presence_of :day, :hour, :duration, :description
  validate :ownership, on: [:update, :destroy]
  validate :not_past, on: [:create, :update]
  validate :set_end_time
  validate :free_range
  before_create :set_end_time

  before_destroy :ownership, prepend: true do
    throw(:abort) if errors.present?
  end

  def show_duration
    if duration == 1.0
      'Uma hora'
    elsif duration == 2.0
      'Duas horas'
    else
      'Três horas'
    end
  end

  def range
    range = []
    duration.to_i.times do |step|
      range << parse_range(hour[0..1].to_i + step)
    end
    range
  end

  def parse_range(num)
    if num < 10
      "0#{num}:00"
    else
      "#{num}:00"
    end
  end

  private

  def set_end_time
    if hour.nil? || duration.nil?
      self.endtime = nil
    else
      t = hour[0..1].to_i + duration
      self.endtime = t < 10 ? "0#{t.to_i}:00" : "#{t.to_i}:00"
    end
    accepted_endtime
  end
  
  def ownership
    errors.add(:user, 'Um usuário não deve poder mexer na reserva de outro') if user != current_user
  end

  def not_past
    if day.nil?
      errors.add(:day, 'Impossível calcular a data como nil')
      return
    end
    errors.add(:day, 'O dia da reserva não pode ser uma data no passado') if day.past?
  end

  def accepted_endtime
    if endtime.nil?
      errors.add(:endtime, 'Impossível calcular a data como nil')
      return
    end
    errors.add(:endtime, 'A hora final não pode ultrapassar meia noite') if endtime[0..1].to_i > 24
  end

  def free_range
    reserva = Appointment.where(day: day).where.not(id: id)
    restrict = 0
    reserva.each do |day|
      restrict += 1 if day.range.include?(hour)
    end
    errors.add(:renge, 'Os horarios de uso da sala não devem bater') unless restrict.zero?
  end 
end
