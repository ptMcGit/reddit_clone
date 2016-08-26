Rails.application.routes.draw do
  devise_for :users

  root 'rooms#index'


  get "/posts" => "posts#index"

  concern :voteable do
    resources :votes
  end

  resources :users, :comments

  resources :rooms, shallow: true  do
    resources :posts, concerns: :voteable
  end

  # if no route matches
  match ":url", to: redirect('/404'), via: :all

end
