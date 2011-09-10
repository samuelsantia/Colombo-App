class UsersController < ApplicationController

  # GET /registrarse
  def new
    @user = User.new
    @title = 'Registrarse'
  end
  
  # POST users/create
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
