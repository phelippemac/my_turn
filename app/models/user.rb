class User < ApplicationRecord

  validates :name, presence: true
  validates :permiss, presence: true

  enum permiss:['root', 'normal']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
