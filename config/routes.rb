Rails.application.routes.draw do

  root 'events#index'
  devise_for :users
  
  resources :events do
  	resources :attendances, only: [:index, :new, :create]
    resources :photos, only: [:create]
  end
  
  resources :users, only: [:show, :edit, :update] do
  	resources :avatars, only: [:create]
  end
  
  namespace :super_admin do
    root 'super_admins#index'
    resources :users
    resources :events
    resources :event_submissions, except: [:new, :create, :destroy]
  end
end
