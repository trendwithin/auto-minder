Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#home'
  resources :geo_tag_vehicles, only: [:index, :new, :show, :create]
  resources :tag_my_vehicles, only: [:new, :create, :show]
  get 'test_page/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
