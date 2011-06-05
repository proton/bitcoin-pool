BitcoinPool::Application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => "registrations"
  }
  
  resource :user, :only => [:edit, :update, :show] do
    resources :workers do
      member do
        post :cash_out
      end
    end

    resources :payments, :only => [:index, :show]
  end
  
  namespace :user do
    root :to => "users#show"
  end

  namespace :admin do
    root :to => "application#main"

    %w{users workers share_prices settings}.each { |r| resources(r) { as_routes }}
  end

  resources :blocks, :only => [:index]
  
  root :to => "informations#welcome"
end
