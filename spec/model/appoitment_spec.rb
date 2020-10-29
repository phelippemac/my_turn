require 'rails_helper'

RSpec.describe Appointment, type: :model do

    it 'A criação da Reserva é válida se feita a partir do presente' do
      user = User.create(
      email: 'root@root',
      password: 'root123',
      password_confirmation: 'root123',
      name: 'ROOT',
      permiss: 0
    )
    
    p user
    @reserva1 = Appointment.new
    @reserva1.day = (Time.now + 2.days).strftime("%d/%m/%Y")
    @reserva1.hour = "10:00"
    @reserva1.description = "Descrição"
    @reserva1.duration = 1.0
    @reserva1.user = user
    expect(@reserva1.save!).to be_truthy
  end

  it 'A criação da reserva é impedida ao ser criada com dara passada' do
    @reserva2 = Appointment.new
    @reserva2.day = (Time.now - 2.days).strftime("%d/%m/%Y")
    @reserva2.hour = "10:00"
    @reserva2.description = "Descrição"
    @reserva2.duration = 1.0
    @reserva2.user
    expect(@reserva2.save!).to be_falsey
  end

  it 'A alteração da Reserva só pode ser feita pelo usuário que a criou' do
    @reserva = Appointment.first
    current_user = @reserva.user
    current_user
  end
  it 'A exclusão da reserva só pode ser feita pelo usuário que a criou caso a data não tenha passado'

  it 'A edição da reserva só pode ser realizada antes da data da mesma passar'

end