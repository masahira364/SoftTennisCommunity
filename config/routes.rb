Rails.application.routes.draw do
  get 'teams/index'
  get 'teams/show'
  get 'teams/edit'
  get 'users/show'
  get 'users/edit'
  root 'home#top'
  get 'home/about'
  devise_for :users

  resources :users

  resources :teams
  get 'teams/team_map'
  get 'teams/team_calendar'
  get 'teams/team_search'
  get 'teams/following_team'

  resources :articles do
  	resources :comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
