require 'resque/server'

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  # get 'product/index'
  # get 'product/create'
  # get 'product/new'
  # # get 'user/index'
  get 'products/bulk_create'
  get 'order_details/bulk_create'
  # # get 'user/export'

  # bulk_create

  resources :products do
    collection do
      get 'download'
      # get 'bulk_create'
    end
  end

  resources :users do
    member do
      get 'export'
    end
    collection do
      get 'download'
      # get 'bulk_create'
    end
  end  

  resources :order_details do
    member do
      get 'export'
    end
    collection do
      get 'download'
      # get 'bulk_create'
    end
  end 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount Resque::Server.new, at: "/resque"


end
