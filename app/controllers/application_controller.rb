class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_user
    @current_user ||= User.find_by_email(session[:email]) if session[:email]
  end
  helper_method :current_user
  
  def current_admin
    @current_admin ||= Admin.find_by_username(session[:username]) if session[:username]
  end
  helper_method :current_admin

  def authorize
    redirect_to '/login' unless current_user
  end
  
  def admin_authorize
    redirect_to "/admin-login" unless current_admin 
  end
end
