class Appointment < ApplicationRecord
  belongs_to :user

  attr_accessor :current_user

  validates_presence_of :day, :hour, :duration, :description
  validate :ownership, on: [:update, :destroy]
  validate :not_past, on: [:create, :update]

  before_destroy :ownership, prepend: true do
    throw(:abort) if errors.present?
  end

  private

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
end
