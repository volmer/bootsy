Rails.application.routes.draw do

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  root to: 'posts#index'

  mount Bootsy::Engine => "/bootsy", :as => 'bootsy'
end
