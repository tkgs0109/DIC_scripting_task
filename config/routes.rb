Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users
  get '/tasks/descendant', to: 'tasks#descendant'
  resources :tasks
end
