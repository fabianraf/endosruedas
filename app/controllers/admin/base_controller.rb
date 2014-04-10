class Admin::BaseController < ApplicationController
  layout 'home_admin'
  before_filter :authenticate_user!
  
  private
  
    def authenticate_admin!
      authenticate_user!
      unless current_user && current_user.has_role?(:admin)
        redirect_to root_path
      end
    end
    
end
