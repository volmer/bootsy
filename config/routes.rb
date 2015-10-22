Bootsy::Engine.routes.draw do
  resources :images, only: [:create]
end
