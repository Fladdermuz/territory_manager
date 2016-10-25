# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_locale



 def set_locale # if params[:locale] is nil then I18n.default_locale will be used
     I18n.locale = session[:locale]
 end


  def login_required
     if session[:user]
     return true
    else
     session[:return_to]=request.request_uri
    redirect_to :controller => "login"
    return false
  end
  end


def isadminuser
  if session[:role] == "admin" or  session[:role] == "congadmin"
   return true
  else
   redirect_to :controller => "main"
   return false
  end
end



  def current_user
    session[:user]
  end



  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to]=nil
      redirect_to(return_to)
    else
      redirect_to :controller=>'main', :action=>'index'
    end
  end



end
