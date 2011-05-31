BitcoinPool::Application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => "registrations"
  }
  
  resource :user, :only => [:edit, :update, :show] do
    resources :workers
  end
  
  namespace :user do
    root :to => "users#show"
  end
  
  root :to => "informations#welcome"
end
