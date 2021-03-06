Rails.application.routes.draw do
  devise_for :users

  root 'rooms#index'


  get "/posts" => "posts#index"


  concern :voteable do
    post '/votes(.:format)', to: 'votes#vote'
    #resources :votes
  end

  resources :users

  resources :rooms, shallow: true  do
    resources :posts, concerns: :voteable do
      resources :comments
    end
  end

  # if no route matches
  match ":url", to: redirect('/404'), via: :all

end
