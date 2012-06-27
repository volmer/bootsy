Bootsy::Engine.routes.draw do
  resources :images, :only => [:index, :create, :update, :destroy]

end
