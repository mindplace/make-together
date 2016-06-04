Rails.application.routes.draw do

  root :to => 'application#index'

  # sessions routes
  get   'login',  to: "sessions#new"
  post  'login',  to: "sessions#create"
  get   'logout', to: "sessions#destroy"

  # Github
  get '/auth/github/callback', to: 'omniauth#github'

  # Dribbble
  get '/users/dribbble',          to: 'omniauth#passthru', as: "user_dribbble_authorize"
  get '/users/dribbble_request',  to: 'omniauth#dribbble_oauth_request', as: "user_dribbble_oauth_request"
  get '/users/auth/dribbble/callback', to: 'omniauth#passthru', as: "user_dribbble_callback"

  get '/favorites', to: 'favorites#show'
  get 'users/conversations/:id', to: 'conversations#show'
  get '/users/mail_conversations', to: 'conversations#mail'
  post '/mail_conversations', to: 'conversations#mail', as: 'mail
  '

  resources :conversations do
    resources :messages
  end

  get '/search', to: 'tags#show', as: "search"

  resources :users
  resources :projects
  resources :skills, except: [:index]
  resources :tags, except: [:index]
  resources :favorites, only: [:create, :destroy]
  resources :reviews, except: [:index, :show]

  # static pages
  get '/contact', to: "application#contact", as: "contact"
  get '/report_abuse', to: "application#report_abuse", as: "report_abuse"
  get '/creators', to: "application#creators", as: "creators"
end
