class ContactUs < ActionMailer::Base
  
  def send_email(params)
    
    mail(to: "pablopazmino@hotmail.com",
      from:  params[:p][:email],
     subject: 'Welcome to My Awesome Site')
  end
  
end
