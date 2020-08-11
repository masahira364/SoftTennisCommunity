Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'
  devise_for :users

  resources :users

  resources :teams do
    member do
      get '/calendar' => 'teams#calendar'
      get '/map' => 'teams#map'
    end
  end
  resources :events


  
  get 'teams/following_team'
  get '/team_search' => 'teams#team_search'
  

  resources :articles do
  	resources :comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
