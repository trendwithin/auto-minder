Rails.application.routes.draw do
  root to: 'static_pages#home'

  get 'test_page/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
