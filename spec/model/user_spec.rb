require 'rails_helper'

RSpec.describe User, type: :model do

  it 'É usuário root se for o primeiro e Permiss = 0' do
    root = User.new
    root.email = 'root@root'
    root.password = 'root123'
    root.password_confirmation = 'root123'
    root.name = 'ROOT'
    root.permiss = 0
    root.save
    expect(root.permiss).to eq(0)
    expect(root.id).to eq(1)
  end

  it 'É válido quando criado com e-mail, senha, nome e permissão' do
    @admin = User.new
    @admin.email = 'admin@admin'
    @admin.password = 'admin123'
    @admin.password_confirmation = 'admin123'
    expect(@admin.save).to be_falsey
  end

  it 'User recebe por padrão Permiss = 1 ao ser criado' do
    user = User.new
    user.email = 'user@user'
    user.password = 'user123'
    user.password_confirmation = 'user123'
    user.save
    expect(user.permiss).to eq(1)
  end

end