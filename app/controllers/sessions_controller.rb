class SessionsController < ApplicationController
  
  # GET /login
  # render a login form
  def new
    @title = "Entrar"
  end
  
  # POST sessions
  # post the session parameters authenticate user
  # if user exist sign_in the user
  # if user doesn't exist or is bad combination re render login form and shown the error
  # @params session identificator
  # @param session password
  def create
    user = User.authenticate(params[:session][:identificator], params[:session][:password])
    if user.nil?
      @title = "Entrar"
      render "new"
    else
      redirect_to root_path
    end
  end
  
  def destroy
    
  end

end
