class SessionsController < Devise::SessionsController
  skip_before_filter :require_no_authentication, :only => [:new, :create]

  def new
    session[:return_to] ||= request.referrer
    super
  end
  
  def create
    super
    if user_signed_in?
      session[:user_id] = current_user.id
      session[:logged_in_by_password] = 'yes'  
      current_user.remember_me! if current_user.remember_me.blank?
      cookies.permanent.signed[:auth_token] = {
        :value => current_user.remember_me
        }
        
    end
  end
  
  def destroy
    super
    cookies[:auth_token] = nil
  end
  
protected

def after_inactive_sign_up_path_for(resource)
  root_url(:protocol => 'http')
end

def after_sign_up_path_for(resource)
  root_url(:protocol => 'http')
end

def after_update_path_for(resource)
  edit_user_registration_url(:protocol => 'http')
end


  def after_sign_in_path_for(resource)
    edit_user_registration_url
  end

end