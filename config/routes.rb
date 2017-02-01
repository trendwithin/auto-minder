Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#home'
  resources :geo_tag_vehicles
  resources :tag_my_vehicles
  get 'test_page/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
