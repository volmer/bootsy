Rails.application.routes.draw do

  resources :posts do
    resources :images, :controller => 'bootsy/images', :only => [:create, :update, :destroy]
  end

  mount Bootsy::Engine => "/bootsy", :as => 'bootsy'
end
