class Appointment < ApplicationRecord
  belongs_to :user
  scope :activeDate, ->(d1, d2) { where('day BETWEEN ? AND ?', d1, d2) }
end
