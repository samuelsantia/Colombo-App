class UsersController < ApplicationController
  before_filter :non_signed_user, :only => [:new, :create]
  before_filter :authenticate,    :only => [:my_account, :update]
  before_filter :assigns_user,    :only => [:my_account, :update]
  
  # GET registrarse
  # render a register form
  def new
    @user = User.new
    @title = t 'users.new.title'
  end
  
  # POST users
  # Post params user and try to save in bbdd
  # if success redirecto to the root path
  # if failure re render the register form
  # @params user
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = t "users.create.success"
      redirect_to root_path
    else
      @title = 'Registrarse'
      render :action => 'new'
    end
  end
  
  # GET mi-cuenta
  # render a form for change current user settings
  def my_account
    @title = t "users.my_account.title"
  end
  
  # PUT update
  # puts params user and try to save in bbdd
  # if success redirect to my_account
  # if failure re render the edit form
  # @params user
  def update
    if @user.update_attributes params[:user]
      flash[:success] = t "users.my_account.success"
      redirect_to my_account_path
    else
      @title = t "users.my_account.title"
      render 'my_account'
    end
  end
  
  private

    # assigns the user to the current user
    def assigns_user
      @user = current_user
    end

    # check if the user is not logedin else redirect to the root path
    def non_signed_user
      redirect_to(root_path) if loged_in?
    end
end
