BitcoinPool::Application.routes.draw do
  devise_for :users
  
  resource :user, :only => [:edit, :update], :controller => "users" do
    root :to => "informations#welcome"
  end
  
  root :to => "informations#welcome"
end
