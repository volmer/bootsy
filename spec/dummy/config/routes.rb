# frozen_string_literal: true
Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  resources :posts do
    resources :comments, only: [:create, :destroy, :update]
  end

  resources :simple_form_posts, only: [:new, :create]

  root to: 'posts#index'
end
