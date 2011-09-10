class UsersController < ApplicationController

  # GET /registrarse
  # render a register form
  def new
    @user = User.new
    @title = 'Registrarse'
  end
  
  # POST users
  # Post params user and try to save in bbdd
  # if success redirecto to the root path
  # if failure re render the register form
  # @params user
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
  
end
