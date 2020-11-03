Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  get 'home/system'
  patch 'home/link', defaults: { format: 'js' }
  patch 'home/view', defaults: { format: 'js' }
  patch 'home/edit', defaults: { format: 'js' }
  patch 'home/show_message', to: 'home#show_message'
  resources :bases
  resources :settings, except: %I[new edit]
  patch 'setting/alteration', to: 'settings#alteration', defaults: { format: 'js' }
  resources :appointments, except: %I[index new edit]
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
