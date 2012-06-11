
class LoginController < ApplicationController
  layout "default"

  include WikiCloth

  caches_page :show
  def new
    @user = User.new
  end

  def create
	if params[:user][:email].blank?
		flash[:error_login] = 'Email Required.'
		redirect_to :action => "new"
	elsif params[:user][:password].blank?
		flash[:error_login] = 'Password Requied.'
		redirect_to :action => "new"
	elsif user = User.authenticate(params[:user][:email],params[:user][:password])
		session[:user_id] = user.id
		flash[:error_login] = 'Login successfully.'
		redirect_to :controller => "pages", :action => "index"
    else
  		flash[:error_login] = 'Credentials you entered are not valid. Please check the spelling for both email address and password.'
	    redirect_to :action => "new"
    end
  end

  def logout
    session[:user_id] = nil
	flash[:notice] = 'Logout successfully.'
    redirect_to :controller => "login", :action => "new"
  end

end
