Rails.application.routes.draw do
  #get 'home/index'
  get 'home/zipcode'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  post 'zipcode' => 'home#zipcode'
end
