ColomboApp::Application.routes.draw do
  
  resources :users, :only => [:create]
  resources :sessions, :only => [:create]
  
  match '/registrarse', :to => 'users#new', :via => :get
  match '/login', :to => 'sessions#new', :via => :get
  match '/logout', :to => 'sessions#destroy', :via => :get
  
  root :to => 'pages#home', :via => :get
end
