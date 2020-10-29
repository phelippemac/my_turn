require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe Appointment, type: :model do

  let(:user) { User.create(name: "João", email: "joao@gmail.com", password: '123', password_confirmation: '123')}
  let(:user) { User.create(name: "Phelippe", email: "phelippe@gmail.com", password: '123', password_confirmation: '123')}
 
  it 'A criação da Reserva é válida se feita a partir do presente' do
    reserva = Appointment.new
    reserva.day = (Time.now + 2.days).strftime("%d/%m/%Y")
    reserva.hour = "10:00"
    reserva.description = "Descrição"
    reserva.duration = 1.0
    reserva.user = User.last
    expect(reserva.save).to eq(true)
  end

  it 'A criação da reserva é impedida ao ser criada com data passada' do
    reserva = Appointment.new
    reserva.day = (Time.now - 2.days).strftime("%d/%m/%Y")
    reserva.hour = "10:00"
    reserva.description = "Descrição"
    reserva.duration = 1.0
    reserva.user = User.last
    expect(reserva.save).to eq(false)
  end

  it 'A alteração da Reserva só pode ser feita pelo usuário que a criou' do
    create_appointment((Time.now ).strftime("%d/%m/%Y"))
    x = Appointment.last
    login_as(User.first, scope: :user)
    x.description = 'Editado'
    expect(x.save).to eq(false)
  end

  it 'A edição da reserva só pode ser realizada antes da data da mesma passar' do
    reserva = create_appointment((Time.now ).strftime("%d/%m/%Y"))
    reserva.update_attribute(:day, (Time.now - 2.days).strftime("%d/%m/%Y"))

    expect(reserva.save).to eq(false)
  end
  
  it 'A exclusão da reserva só pode ser feita pelo usuário que a criou' do
    reserva = create_appointment((Time.now ).strftime("%d/%m/%Y"))
    login_as(User.first, scope: :user)
    expect(reserva.destroy).to eq(false)
  end

  it 'A exclusão da reserva só pode ser feita caso sua data não tenha passado' do
    reserva = create_appointment((Time.now ).strftime("%d/%m/%Y"))
    reserva.update_attribute(:day, (Time.now - 2.days).strftime("%d/%m/%Y"))
    id = reserva.id
    reserva.destroy
    expect(Appointment.find(id)).to raise_error("Couldn't find Appointment with 'id'=#{id}")
  end

  def create_appointment(date)
    Appointment.create!(
      day: date,
      hour: '10:00',
      description: 'description',
      duration: 1.0,
      user: User.last
    )
  end
end