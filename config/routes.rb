Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks',
  }

  resources :users do
    get '/bookmarks' => 'users#bookmarks', on: :member
    get '/favorites' => 'users#favorites', on: :member
    get '/entries' => 'users#entries', on: :member
  end

  get '/confirm' => 'users#confirm'

  resources :teams, shallow: true do
    resource :bookmarks, only: %i(create destroy)
    resource :relationships, only: [:create, :destroy]
    resources :approvals, only: [:create, :destroy]
    get '/matching' => 'relationships#matching'
    get :bookmarks, on: :collection
    member do
      get '/calendar' => 'teams#calendar'
      get '/map' => 'teams#map'
      get '/member' => 'teams#member'
      get '/approvals' => 'teams#approvals'
    end
  end

  resources :events do
    resource :entries, only: [:create, :destroy]
  end

  get '/search' => 'teams#search'
  get '/team_search' => 'teams#team_search'

  resources :articles do
    resources :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :notifications, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
