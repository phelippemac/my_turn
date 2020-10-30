require 'rails_helper'

#include Warden::Test::Helpers
#Warden.test_mode!

RSpec.describe Appointment, type: :model do

  DATA_PRESENTE = Time.current.strftime('%d/%m/%Y')
  DATA_PASSADA = (Time.current - 2.days).strftime('%d/%m/%Y')

  def create_appointment(date)
    Appointment.create!(
      day: date,
      hour: '10:00',
      description: 'description',
      duration: 1.0,
      user: User.last
    )
  end

  before(:each) do
    User.create(name: 'João', email: 'joao@gmail.com', password: '123', password_confirmation: '123')
    User.create(name: 'Phelippe', email: 'phelippe@gmail.com', password: '123', password_confirmation: '123')
  end

  context 'Referente a criação' do
    it 'A criação da Reserva é válida se feita a partir da data presente' do
      reserva = Appointment.new
      reserva.day = DATA_PRESENTE
      reserva.hour = '10:00'
      reserva.description = 'Descrição'
      reserva.duration = 1.0
      reserva.user = User.last
      expect(reserva.save).to eq(true)
    end

    it 'A criação da reserva é impedida ao ser criada com data passada' do
      reserva = Appointment.new
      reserva.day = DATA_PASSADA
      reserva.hour = '10:00'
      reserva.description = 'Descrição'
      reserva.duration = 1.0
      reserva.user = User.last
      expect(reserva.save).to eq(false)
    end
  end

  context 'Referente a edição' do
    it 'A alteração da Reserva só pode ser feita pelo usuário que a criou' do
      create_appointment(DATA_PRESENTE)
      x = Appointment.last
      x.description = 'Editado'
      expect(x.save).to eq(false)
    end

    it 'A edição da reserva só pode ser realizada antes da data da mesma passar' do
      reserva = create_appointment(DATA_PRESENTE)
      reserva.update_attribute(:day, DATA_PASSADA)

      expect(reserva.save).to eq(false)
    end
  end
  
  context 'Referente a exclusão' do
    it 'A exclusão da reserva só pode ser feita pelo usuário que a criou' do
      reserva = create_appointment(DATA_PRESENTE)
      reserva.current_user = reserva.user
      reserva.save
      expect{ reserva.destroy! }.to change(Appointment, :count).by(-1)
    end

    it 'A exclusão da reserva só pode ser feita caso sua data não tenha passado' do
      reserva = create_appointment(DATA_PRESENTE)
      reserva.update_attribute(:day, DATA_PASSADA)
      reserva.destroy
      expect{ reserva.destroy }.to change(Appointment, :count).by(0)
    end
  end
end