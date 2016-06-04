Rails.application.routes.draw do

  root :to => 'application#index'

  devise_for :users, controllers:{
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/auth/:provider/callback', to: 'users/sessions#create'

  devise_scope :user do
    get '/users/sign_out', to: 'users/sessions#destroy'
    # Dribbble
    get '/users/dribbble',          to: 'users/registrations#passthru', as: "user_dribbble_authorize"
    get '/users/dribbble_request',  to: 'users/registrations#dribbble_oauth_request', as: "user_dribbble_oauth_request"
    get '/users/auth/dribbble/callback', to: 'users/registrations#passthru', as: "user_dribbble_callback"
  end

  resources :users, except: [:create, :new]
  resources :projects
  resources :skills, except: [:index]
  resources :tags, except: [:index]
  resources :favorites
  resources :reviews, except: [:index, :show]

  # static pages
  get '/contact', to: "application#contact", as: "contact"
  get '/report_abuse', to: "application#report_abuse", as: "report_abuse"
  get '/creators', to: "application#creators", as: "creators"
end
