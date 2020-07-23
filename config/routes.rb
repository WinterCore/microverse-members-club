Rails.application.routes.draw do
  resources :posts, except: [:show, :new]
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'
end
