Rails.application.routes.draw do
  root to: 'orders#new'

  resources :orders
  get 'order/:permalink', to: 'orders#permalink', as: :order_permalink
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
