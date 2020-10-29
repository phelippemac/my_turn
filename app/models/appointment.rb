class Appointment < ApplicationRecord
  belongs_to :user

  attr_accessor :current_user

  validates_presence_of :day, :hour
  validate :ownership, on: [:update, :destroy]
  validate :not_past, on: [:create, :update]

  private

  def ownership
    if user != current_user
      errors.add(:user, 'Um usuário não deve poder mecher na reserva de outro')
    end
  end

  def not_past
    if day.past?
      errors.add(:day, 'O dia da reserva não pode ser uma data no passado')
    end
  end
end
