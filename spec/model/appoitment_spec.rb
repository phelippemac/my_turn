require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe Appointment, type: :model do

  let(:user) { User.create(name: "João", email: "joao@gmail.com", password: '123', password_confirmation: '123')}
  let(:user) { User.create(name: "Phelippe", email: "phelippe@gmail.com", password: '123', password_confirmation: '123')}
 
  it 'A criação da Reserva é válida se feita a partir do presente' do
    @user = User.last
    reserva = Appointment.new
    reserva.day = (Time.now + 2.days).strftime("%d/%m/%Y")
    reserva.hour = "10:00"
    reserva.description = "Descrição"
    reserva.duration = 1.0
    reserva.user = @user
    expect(reserva.save!).to be_truthy
  end

  it 'A criação da reserva é impedida ao ser criada com dara passada' do
    @user = User.last
    reserva = Appointment.new
    reserva.day = (Time.now - 2.days).strftime("%d/%m/%Y")
    reserva.hour = "10:00"
    reserva.description = "Descrição"
    reserva.duration = 1.0
    reserva.user
    expect(reserva.save).to be_falsey
  end

  it 'A alteração da Reserva só pode ser feita pelo usuário que a criou' do
    @user = User.last
    reserva = Appointment.new
    reserva.day = (Time.now + 2.days).strftime("%d/%m/%Y")
    reserva.hour = "10:00"
    reserva.description = "Descrição"
    reserva.duration = 1.0
    reserva.user = @user
    reserva.save
    x = Appointment.last
    login_as(User.first, scope: :user)
    x.description = 'Editado'
    expect(x.save).to be_falsey
  end

  it 'A edição da reserva só pode ser realizada antes da data da mesma passar' do
    @user = User.last
    reserva = Appointment.new
    reserva.day = 6.days.ago
    reserva.hour = "10:00"
    reserva.description = "Descrição"
    reserva.duration = 1.0
    reserva.user = @user
    reserva.save!
    x = Appointment.last
    today = Time.now + 2.days
    expect(x.day.to_date < today).to be_truthy
  end
  
  it 'A exclusão da reserva só pode ser feita pelo usuário que a criou caso a data não tenha passado' do
    
  end

  

end