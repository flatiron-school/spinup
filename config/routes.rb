Rails.application.routes.draw do
  root 'sessions#new'
  get '/auth/github/callback' => 'sessions#create', as: 'github_callback'
  get '/auth/github' => 'auth#github', as: 'github_login'
  get '/droplets/new' => 'droplets#new', as: 'new_droplets'
end