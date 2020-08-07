Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'
  devise_for :users

  resouces :users

  resouces :teams
  get 'teams/team_map'
  get 'teams/team_calendar'
  get 'teams/team_search'
  get 'teams/following_team'

  resouces :articles do
  	resouces :comments, only[:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
