require 'rails_helper'

RSpec.describe User, type: :model do

  context 'Teste de validação' do
    it 'É válido quando criado com e-mail, senha, nome e permissão' do
      user = User.new
      user.email = 'admin@admin'
      user.password = 'admin123'
      user.password_confirmation = 'admin123'
      expect(user.save).to eq(false) # Precisa de nome
      user.name = 'Joao'
      expect(user.save).to eq(true)
    end
  end

  context 'Teste de Escopo Padrão' do
    it 'É usuário root se for criado com Permiss = 0' do
      root = User.new
      root.email = 'root@root'
      root.password = 'root123'
      root.password_confirmation = 'root123'
      root.name = 'ROOT'
      root.permiss = 0
      root.save
      expect(root.permiss).to eq('root')
    end

    it 'User recebe por padrão Permiss = 1 ao ser criado' do
      user = User.new
      user.email = 'user@user'
      user.password = 'user123'
      user.password_confirmation = 'user123'
      user.name = 'Padrão'
      user.save
      expect(user.permiss).to eq('normal')
    end
  end
end