Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  get 'home/system'
  get 'home/link'
  get 'home/view'
  get 'home/edit'
  resources :bases
  resources :settings
  resources :appointments
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
