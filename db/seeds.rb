# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p "Criando configurações padrão"
@setting = Setting.new
p "Configurações salvas com sucesso" if @setting.save

p "Criando usuário Root"
@user = User.new
@user.name = 'Root'
@user.email = 'admin@admin.com'
@user.password = 'root123'
@user.password_confirmation = 'root123'
@user.permiss = 0
p "Usuário ROOT criado com sucesso" if @user.save
