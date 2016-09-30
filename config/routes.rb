Rails.application.routes.draw do

  root :to => 'application#index'

  # sessions routes
  get   'login',  to: "sessions#new"
  post  'login',  to: "sessions#create"
  get   'logout', to: "sessions#destroy"

  # Github
  get '/auth/github/callback', to: 'omniauth#github'

  post '/omniauth/password', to: 'omniauth#password', as: "omniauth_set_password"

  get 'users/conversations/:id', to: 'conversations#show'
  get '/users/mail_conversations', to: 'conversations#inbox', as: 'inbox'
  get '/users/inbox_conversations/:id', to: 'conversations#inbox_messages_show', as: 'inbox_messages_show'
  post '/users/inbox_conversations/:id', to: 'messages#create', as: 'inbox_message'

  get '/posted', to: 'projects#posted_show', as: 'posted'


  resources :conversations do
    resources :messages
  end


  resources :reports, only: [:new, :create]


  post '/search', to: 'tags#show', as: "search"


  resources :users
  resources :projects
  resources :skills, except: [:edit, :update, :index]
  resources :tags, except: [:index]
  resources :reviews, except: [:index, :show]
  resources :followings, only: [:create, :index, :destroy]
  resources :favorites, only: [:create, :index, :destroy]
  resources :flagged_projects, only: [:create, :show, :destroy]

  # get 'flagged/new', to: "flagged_projects#create", as: "new_flagged_project"
  # get 'flagged', to: "flagged_projects#show", as: "flagged"
  # get 'flagged/delete', to: "flagged_projects#destroy", as: "delete_flagged_project"

  # admin
  get '/admin', to: "users#admin", as: "admin"

  # static pages
  get '/contact', to: "application#contact", as: "contact"
  post '/contact', to: "reports#create", as: 'new_contact'
  get '/report_abuse', to: "application#report_abuse", as: "report_abuse"
  get '/creators', to: "application#creators", as: "creators"
end
