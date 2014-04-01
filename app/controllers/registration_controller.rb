class RegistrationsController < Devise::RegistrationsController
  # force_ssl :only => [:new, :create, :edit, :update] if Rails.env.production?

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
end