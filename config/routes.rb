Rails.application.routes.draw do
  
  root to: 'home#index'
  # resources :searches
  devise_for :users
  resources :venues
  resources :gigs
  resources :schedules do 
    resources :bookings
  end
  
  resources :genres
  # resources :users


end