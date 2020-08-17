Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'
  devise_for :users

  resources :users do
    get '/bookmarks' => 'users#bookmarks', on: :member
  end

  resources :teams, shallow: true do
    resource :bookmarks, only: %i[create destroy]
    resource :relationships, only: [:create, :destroy]
    get '/matching' => 'relationships#matching'
    get :bookmarks, on: :collection
    member do
      get '/calendar' => 'teams#calendar'
      get '/map' => 'teams#map'
      get '/member' => 'teams#member'
    end
  end
  
  resources :events

  get '/search' => 'teams#search'
  get '/team_search' => 'teams#team_search'

  resources :articles do
  	resources :comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
