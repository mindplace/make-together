Rails.application.routes.draw do

  devise_for :users, controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root :to => 'application#index'

  devise_scope :user do
    get '/users/sign_out', to: 'users/sessions#destroy'
  end
end
