class SessionsController < ApplicationController
  
  # GET iniciar-sesion
  # render a login form
  def new
    @title = t "sessions.new.title"
  end
  
  # POST sessions
  # post the session parameters authenticate user
  # if user exist sign_in the user
  # if user doesn't exist or is bad combination re render login form and shown the error
  # @params session identificator
  # @params session password
  def create
    user = User.authenticate(params[:session][:identificator], params[:session][:password])
    if user.nil?
      flash.now[:error] = t "sessions.create.error"
      @title = t "sessions.new.title"
      render "new"
    else
      log_in user, params[:session][:remember_me].to_i
      redirect_back_or
    end
  end
  
  # GET salir
  # log_out a user and redirect to the root_path
  def destroy
    log_out
    redirect_to root_path
  end

end
