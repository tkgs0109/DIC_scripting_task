Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users
  get '/tasks/descendant', to: 'tasks#descendant'
  resources :tasks
  resources :relationals
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
