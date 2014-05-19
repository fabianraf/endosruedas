class ContactUsController < ApplicationController

  def sendEmail
    puts params[:p]
    @name = params[:p][:name]
    render "contact_us/sentEmail"
  end
  
end