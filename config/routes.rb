Bootsy::Engine.routes.draw do
  resources :attachments, only: [:create]
end
