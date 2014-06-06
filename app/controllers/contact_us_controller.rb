class ContactUsController < ApplicationController

  def sendEmail
    puts params[:p]
    @name = params[:p][:name]
    
    ContactUs.send_email(params[:p]).deliver
    render "contact_us/contact_us_thanks"
  end
  
end