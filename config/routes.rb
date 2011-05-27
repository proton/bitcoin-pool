BitcoinPool::Application.routes.draw do
  devise_for :users
  
  root :to => "informations#welcome"
end
