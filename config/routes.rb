Rails.application.routes.draw do
  devise_for :users

  root 'rooms#index'

  concern :voteable do
    resources :votes
  end

  resources :users, :comments

  resources :rooms, shallow: true  do
    resources :posts, concerns: :voteable
  end


end
