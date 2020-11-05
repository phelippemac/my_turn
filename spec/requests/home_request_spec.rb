require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  include Warden::Test::Helpers

  context 'GET para Rotas' do
    it 'GET index: Deve acessar a página index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'GET system: Sem usuário logado deve redirecionar para usuário fazer login' do
      get :system
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'GET system: Com usuário logado deve acessar a página system' do
      Setting.create # A página renderizada precisa das variáveis de pelo menos uma configuração
      user = User.create(name: 'João', email: 'joao@gmail.com', password: '123', password_confirmation: '123')
      sign_in user
      get :system
      expect(response).to render_template(:system)
    end
  end

  context 'Valores do System' do
    before(:each) do
      Setting.create!(max_usage: 1.0, initial_period: '00:00', last_period: '22:00') # A página renderizada precisa das variáveis de pelo menos uma configuração
      user = User.create(name: 'João', email: 'joao@gmail.com', password: '123', password_confirmation: '123')
      sign_in user
    end
    it 'Retorna resultado sem a variavel new_day' do
      get :system
      expect(assigns(:today).strftime('%d/%m/%Y')).to eq(Time.current.strftime('%d/%m/%Y'))
      expect(assigns(:reservations)).to eq(Appointment.in_range(assigns(:today)))
      expect(assigns(:weekdays)).to eq(rotate(assigns(:weekdays), assigns(:today)))
      expect(assigns(:dates)).to eq(find_dates(assigns(:weekdays), assigns(:today)))
    end
    it 'Retorna outros resultados com a variavel new_day' do
      get :system, params: {new_day: '01/12/2020'}
      expect(assigns(:today).strftime('%d/%m/%Y')).to eq('01/12/2020')
      expect(assigns(:reservations)).to eq(Appointment.in_range(assigns(:today)))
      expect(assigns(:weekdays)).to eq(['Terça', 'Quarta', 'Quinta', 'Sexta', 'Segunda'])
      expect(assigns(:dates)).to eq(['01/12/2020', '02/12/2020', '03/12/2020', '04/12/2020', '07/12/2020'])
    end
  end

  def rotate(arr, day)
    if day.monday? || day.sunday? || day.saturday?
      rotate = 0
    elsif day.tuesday?
      rotate = 1
    elsif day.wednesday?
      rotate = 2
    elsif day.thursday?
      rotate = 3
    elsif day.friday?
      rotate = 4
    end
    rotate.times do
      arr << arr.shift
    end
    arr
  end

  def find_dates(weekdays, day)
    dd = 0
    dates = []
    weekdays.each do |_day|
      if (day + dd).saturday?
        dd += 2
      elsif (day + dd).sunday?
        dd += 1
      end
      dates << (day + dd.days).strftime('%d/%m/%Y')
      dd += 1
    end
    return dates
  end

end
