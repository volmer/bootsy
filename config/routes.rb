Bootsy::Engine.routes.draw do
  resources :image_galleries, only: [] do
    resources :images, only: [:index, :create, :update, :destroy]
  end

  resources :images, only: [:index, :create, :update, :destroy]
end
