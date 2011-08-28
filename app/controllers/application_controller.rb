class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user 
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Not authorized to view this page."
    logger.info "CanCan::AccessDenied"
    logger.info session.inspect
    
    redirect_to root_path
  end  
  
  def require_user
    logger.info session.inspect
    return true if current_user
    flash[:error] = "You must be logged in to view this page"
    redirect_to root_path
    false
  end 
    
  private  
  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end
end
