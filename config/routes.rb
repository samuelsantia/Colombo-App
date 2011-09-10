ColomboApp::Application.routes.draw do
  resources :users, :only => [:create]
  
  match '/registrarse', :to => 'users#new', :via => :get
  
  root :to => 'pages#home', :via => :get
end
