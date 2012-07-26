Rails.application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  root to: 'posts#index'
end
