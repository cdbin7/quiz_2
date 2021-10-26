Rails.application.routes.draw do

  get('/', {to: 'ideas#index', as: 'root'})

  resources :ideas do
    resources :reviews, only:[:create, :destroy]
    resources :likes, shallow: true, only:[:create, :destroy]
  end

  resources :users, only:[:new, :create]
  resource :session, only:[:new, :create, :destroy]


end
