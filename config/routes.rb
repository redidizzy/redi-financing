Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  get 'stocks/search'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get 'my_portfolio', to:'users#my_portfolio'
  get 'search_stock', to:'stocks#search'

  get 'my_friends', to:'users#my_friends'
  delete 'friendship/:id', to:'friendships#destroy', as: "friendship"
  get 'search_friends', to: 'users#search'
end
