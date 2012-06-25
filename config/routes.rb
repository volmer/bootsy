Bootsy::Engine.routes.draw do
  resources :images, :only => [:create, :update, :destroy]

end
