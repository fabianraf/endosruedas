class SessionsController < Devise::SessionsController
  skip_before_filter :require_no_authentication, :only => [:new, :create]
  layout 'home'
  def new
    session[:return_to] ||= request.referrer
    super
  end
  
  def create
    super
    if user_signed_in?
      session[:user_id] = current_user.id
      session[:logged_in_by_password] = 'yes'  
      current_user.remember_me! if current_user.remember_token.blank?
      cookies.permanent.signed[:auth_token] = {
        :value => current_user.remember_token
        }
        
    end
  end
  
  def destroy
    p "******************"
    super
    cookies[:auth_token] = nil
  end
  
end