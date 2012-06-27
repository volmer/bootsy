Rails.application.routes.draw do

  resources :posts

  mount Bootsy::Engine => "/bootsy", :as => 'bootsy'
end
