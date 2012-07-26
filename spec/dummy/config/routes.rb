Rails.application.routes.draw do

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  root to: 'posts#index'
end
