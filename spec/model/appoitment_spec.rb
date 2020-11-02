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
    User.create!(name: 'João', email: 'joao@gmail.com', password: '123456', password_confirmation: '123456')
    User.create!(name: 'Phelippe', email: 'phelippe@gmail.com', password: '123456', password_confirmation: '123456')
  end

  context 'Referente a criação' do

    context 'Validações' do
      it 'Aceita criação com Dia, Hora, Duração e Descrição' do
        reserva = Appointment.new
        reserva.day = DATA_PRESENTE
        reserva.hour = '10:00'
        reserva.description = 'Teste'
        reserva.duration = 1.0
        reserva.user = User.last
        expect(reserva.save).to eq(true)
      end

      it 'Recusa criação sem Dia' do
        reserva = Appointment.new
        reserva.hour = '10:00'
        reserva.description = 'Teste'
        reserva.duration = 1.0
        reserva.user = User.last
        expect(reserva.save).to eq(false)
      end

      it 'Recusa criação sem Hora' do
        reserva = Appointment.new
        reserva.day = DATA_PRESENTE
        reserva.description = 'Teste'
        reserva.user = User.last
        expect(reserva.save).to eq(false)
      end

      it 'Recusa criação sem Descrição' do
        reserva = Appointment.new
        reserva.day = DATA_PRESENTE
        reserva.hour = '10:00'
        reserva.duration = 1.0
        reserva.user = User.last
        expect(reserva.save).to eq(false)
      end

      it 'Recusa criação sem Duração' do
        reserva = Appointment.new
        reserva.day = DATA_PRESENTE
        reserva.hour = '10:00'
        reserva.user = User.last
        expect(reserva.save).to eq(false)
      end
    end

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

    it 'O encerramento do uso é igual sua Hora mais sua Duração(Condicional com hora acima de 10)' do
      reserva = Appointment.new
      reserva.day = DATA_PRESENTE
      reserva.hour = '10:00'
      reserva.description = 'Teste'
      reserva.duration = 1.0
      reserva.user = User.last
      reserva.save
      expect(reserva.endtime).to eq('11:00')
    end

    it 'O encerramento do uso é igual sua Hora mais sua Duração(Condicional com hora abaixo de 10)' do
      reserva = Appointment.new
      reserva.day = DATA_PRESENTE
      reserva.hour = '06:00'
      reserva.description = 'Teste'
      reserva.duration = 2.0
      reserva.user = User.last
      reserva.save
      expect(reserva.endtime).to eq('08:00')
    end

    it 'A hora do encerramento não deve ultrapassar meia noite' do
      reserva = Appointment.new
      reserva.day = DATA_PRESENTE
      reserva.hour = '23:00'
      reserva.description = 'Descrição'
      reserva.duration = 2.0
      reserva.user = User.last
      expect(reserva.save).to eq(false)
    end

    it 'Deve retornar o intervalo de tempo que a reserva usará' do
      reserva = create_appointment(DATA_PRESENTE)
      reserva.update_attribute(:hour, '08:00')
      reserva.update_attribute(:duration, 3.0)
      expect(reserva.range).to eq(['08:00', '09:00', '10:00'])
    end

    it 'Uma reserva não deve colidir com a outra em questão de tempo' do
      reserva1 = create_appointment(DATA_PRESENTE)
      reserva1.update_attribute(:hour, '08:00')
      reserva1.update_attribute(:duration, 3.0)

      reserva = Appointment.new
      reserva.day = DATA_PRESENTE
      reserva.hour = '10:00'
      reserva.description = 'Descrição'
      reserva.duration = 2.0
      reserva.user = User.last

      expect(reserva.save).to eq(false)
    end

    it 'Uma reserva não deve colidir com a outra em questão de tempo mesmo que seja criado em horário antes' do
      reserva1 = create_appointment(DATA_PRESENTE)
      reserva1.update_attribute(:hour, '10:00')
      reserva1.update_attribute(:duration, 1.0)

      reserva = Appointment.new
      reserva.day = DATA_PRESENTE
      reserva.hour = '09:00'
      reserva.description = 'Descrição'
      reserva.duration = 2.0
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
      reserva.save!
      expect{ reserva.destroy }.to change(Appointment, :count).by(-1)
    end

    it 'A exclusão da reserva não pode ser feita por outro usuário senão aquele que a criou' do
      reserva = create_appointment(DATA_PRESENTE)
      reserva.current_user = User.first
      expect{ reserva.destroy }.to change(Appointment, :count).by(0)
    end

    it 'A exclusão da reserva só pode ser feita caso sua data não tenha passado' do
      reserva = create_appointment(DATA_PRESENTE)
      reserva.update_attribute(:day, DATA_PASSADA)
      expect { reserva.destroy }.to change(Appointment, :count).by(0)
    end
  end
end