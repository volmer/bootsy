Rails.application.routes.draw do

  resources :posts

  root to: 'posts#index'

  mount Bootsy::Engine => "/bootsy", :as => 'bootsy'
end
