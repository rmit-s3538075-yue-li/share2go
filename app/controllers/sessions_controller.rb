class SessionsController < ApplicationController
  def new
  end
  
  def new_admin
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if  user.email_confirmed 
        session[:email] = user.email
        redirect_to '/'
      else
        redirect_to '/', notice: "Please go to your email to activate your account. "
      end
    else
      redirect_to '/login', notice: "Invalid email and password."
    end
  end
  
  def create_admin
    admin = Admin.find_by_username(params[:username])
    if admin && admin.authenticate(params[:password])
      session[:username] = admin.username
      redirect_to '/admins/'+ admin.id.to_s + '/dashboard'
    else
      redirect_to '/admin-login', notice: "Invalid username and password."
    end
  end

  def destroy
    session[:email] = nil
    redirect_to '/'
  end
  
  def destroy_admin
    session[:username] = nil
    redirect_to '/'
  end
end
