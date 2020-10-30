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
end
