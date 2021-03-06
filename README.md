<h1 align="center">
  <img src="https://ik.imagekit.io/795unnjv9m/Meu_portifolio_-_Padr_o_yEh6G0CIc.png">
</h1>

<h3 align="center">
  <img src="https://ik.imagekit.io/795unnjv9m/logo_f_sz-Buza.png" height="180">
</h3>

## Galeria

<img src="https://ik.imagekit.io/795unnjv9m/print_eVkPQFQza.png" height="750">


## Sobre

É um projeto realizado como um prova prática de conhecimentos a de desenvolvimento WEB com Ruby on Rails.
A função deste Web Software é controlar as reservas da sala de reunião de um empresa, de forma a realizar essas tarefas de forma dinâmica.


## Técnologias Utilizadas

- Rails - 6.0.3.2
- Ruby - 2.7.1p83
- PostgreSql
- Bootstrap

## GEMs

- [simple-form](https://github.com/heartcombo/simple_form) - The basic goal of Simple Form is to not touch your way of defining the layout, letting you find the better design for your eyes
gem 'simple_form'
- [devise](https://github.com/heartcombo/devise) - Devise is a flexible authentication solution for Rails based on Warden
- [font-awesome-rails](https://github.com/bokmann/font-awesome-rails) - provides the Font-Awesome web fonts and stylesheets as a Rails engine for use with the asset pipeline.
gem "font-awesome-rails"
- [rails-i18n](https://github.com/svenfuchs/rails-i18n) - Centralization of locale data collection for Ruby on Rails.


## Instalação

Comece clonando este repositório e entrando no diretório criado.

```bash
$ git clone https://github.com/phelippemac/my_turn.git
$ cd my_turn
```

Abra com seu editor de texto favorito e edite o arquivo em *./config* chamado *local_env.yml* com o seguinte conteúdo:

```yml
SAMPLE_APP_DATABASE_USER: '[USUÁRIO DO POSTGRES]'
SAMPLE_APP_DATABASE_PASSWORD: '[SENHA DO USUÀRIO]'
```
*OBS: Este arquivo deve conter o usuário e senha do postgres, para que passa criar e rodar as migrations.*

Rode então o seguinte comando no terminal:

```bash
$ rails db:create db:migrate db:seed
```

O comando anterior criará um usuário Root com Email: 'admin@admin.com' e Senha: 'root123', assim como configurações iniciais.

Posterior a isso, está quase pronto, basta rodar:

```bash
$ rails server
```
ou
```bash
$ rails s
```

E acessar a aplicação no endereço: *localhost:3000*
