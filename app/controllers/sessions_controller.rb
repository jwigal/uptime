class SessionsController < ApplicationController
  skip_authorization_check
  def create  
    auth = request.env["omniauth.auth"]
    logger.info auth.inspect  
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)  
    session[:user_id] = user.id  
    redirect_to root_url, :notice => "Signed in!"  
  end
end
