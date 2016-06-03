Rails.application.routes.draw do

  devise_for :users, controllers:{
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root :to => 'application#index'

  devise_scope :user do
    get '/users/sign_out', to: 'users/sessions#destroy'
  end

  resources :users, except: [:create, :new]

  resources :projects

  # static pages
  get '/contact', to: "application#contact", as: "contact"
  get '/report_abuse', to: "application#report_abuse", as: "report_abuse"
  get '/creators', to: "application#creators", as: "creators"
end
