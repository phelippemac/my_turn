Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  get 'home/system'
  patch 'home/link'
  patch 'home/view'
  patch 'home/edit'
  patch 'home/show_message', to: 'home#show_message'
  resources :bases
  resources :settings
  resources :appointments, except: %I[index new edit]
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
