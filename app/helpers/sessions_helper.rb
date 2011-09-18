module SessionsHelper
  
  # log_in
  # get the user and save in a session or in a cookie if remember true
  # @param user => instance of User
  # @remember => int (0 false, 1 true)
  #
  def log_in(user, remember = 0)
    set_remember_token(user, remember)
    self.current_user = user
  end
  
  def log_out
    clear_remember_token
  end
  
  # current_user=
  # setter @current_user
  # @param user => instance of User
  #
  def current_user=(user)
    @current_user = user
  end
  
  # current_user
  # getter @current_user if no exist try to set with a cookie or session
  #
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  # loged_in?
  # returns if are a user log_in?
  # @return boolean
  #
  def loged_in?
    !current_user.nil?
  end
  
  # current_user?
  # matchs if a user is the current_user
  # @returns boolean
  #
  def current_user?(user)
    user == current_user
  end
  
  # authenticate
  # match if user is loged_in else redirect to login_path
  #
  def authenticate
    deny_access unless loged_in?
  end
  
  # deny_access
  # store the location in a session and redirect to login_path
  #
  def deny_access
    store_location
    redirect_to login_path
  end
  
  # redirect_back_or
  # redirect to the store_location or a default url
  # @param default => default url to redirect
  #
  def redirect_back_or(default = root_path)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  private
    
    # set_remember_token
    # setter of remember_token
    # @param user => User
    # @param remember => int (0 false, 1 true)
    #
    def set_remember_token(user, remember)
      if remember == 1
        cookies.permanent.signed[:remember_token] = [user.id, user.salt]
      else
        session[:remember_token] = [user.id, user.salt]
      end
    end
    
    # remember_token
    # getter remember_token
    # return the array of rembember token or an array with nils valuse
    # @return => array
    #
    def remember_token
      cookies.signed[:remember_token] || session[:remember_token] || [nil, nil]
    end
    
    # clear_remember_token
    # removes the remember token from cookies and sessions
    #
    def clear_remember_token
      cookies.delete(:remember_token)
      session[:remember_token] = nil
    end
    
    # user_from_remember_token
    # authenticate a user from remember token
    # @return => user or nil
    #
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    # store_location
    # save the request path in a session
    #
    def store_location
      session[:return_to] = request.fullpath
    end
    
    # clear_return_to
    # clear the return_to session
    #
    def clear_return_to
      session[:return_to] = nil
    end
end
