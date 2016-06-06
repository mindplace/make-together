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

  get 'users/conversations/:id', to: 'conversations#show'
  get '/users/mail_conversations', to: 'conversations#inbox', as: 'inbox'
  get '/users/inbox_conversations/:id', to: 'conversations#inbox_messages_show', as: 'inbox_messages_show'
  post '/users/inbox_conversations/:id', to: 'messages#create', as: 'inbox_message'
  get "projects/flag" => "projects#flag", :as => "projects/flag"

  resources :conversations do
    resources :messages
  end

  get '/search', to: 'tags#show', as: "search"

  resources :users
  resources :projects
  resources :skills, except: [:index]
  resources :tags, except: [:index]
  resources :reviews, except: [:index, :show]

  get 'favorite/delete', to: "favorites#destroy", as: "delete_favorite"
  get 'favorite', to: "favorites#show", as: "favorite"
  get 'favorites/new', to: "favorites#create", as: "new_favorite"


  # static pages
  get '/contact', to: "application#contact", as: "contact"
  get '/report_abuse', to: "application#report_abuse", as: "report_abuse"
  get '/creators', to: "application#creators", as: "creators"
end
