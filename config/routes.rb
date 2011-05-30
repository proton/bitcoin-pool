BitcoinPool::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  
  resource :user, :only => [:edit, :update], :controller => "users"
  
  root :to => "informations#welcome"
end
