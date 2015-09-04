UnsPark::Engine.routes.draw do
  resources :spaces do
    get "spot" => 'spaces#spot', on: :collection
    get "own" => 'spaces#own', on: :member
  end
  
  resources :subscribers, :only => [:create, :destroy]

  root to: 'spaces#spot'
end
