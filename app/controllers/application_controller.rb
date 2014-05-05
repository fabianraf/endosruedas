class ApplicationController < ActionController::Base
  layout 'home'
  protect_from_forgery
  
  before_filter :set_global_search_variable

  def set_global_search_variable
    @q = Product.search(params[:q])
  end
end
