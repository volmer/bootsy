Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :articles, except: :show

  resources :simple_form_posts, only: [:new, :create]

  root to: 'posts#index'
end
