BitcoinPool::Application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => "registrations"
  }
  
  resource :user, :only => [:edit, :update, :show] do
    resources :workers
    resources :payments, :only => [:index, :show]
  end
  
  namespace :user do
    root :to => "users#show"
  end

  namespace :admin do
    resources(:users) { as_routes }
    resources(:workers) { as_routes }
  end

  resources :blocks, :only => [:index]
  
  root :to => "informations#welcome"
end
