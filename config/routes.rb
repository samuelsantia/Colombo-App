ColomboApp::Application.routes.draw do
  
  # --------------------------------------------------------------------------------
  # USUARIOS
  # --------------------------------------------------------------------------------
  resources :users, :only => [:create, :update], :path => 'usuarios'
  get 'registrarse', :to => 'users#new', :as => :register, :format => false
  get 'mi-cuenta', :to => 'users#my_account', :as => :my_account, :format => false
  
  # --------------------------------------------------------------------------------
  # SESSIONES
  # --------------------------------------------------------------------------------
  resources :sessions, :only => [:create], :path => 'sesiones'
  get 'iniciar-sesion', :to => 'sessions#new', :as => :login, :format => false
  delete 'salir', :to => 'sessions#destroy', :as => :logout, :format => false
  
  root :to => 'pages#home', :via => :get
end
