class MainController < ApplicationController
   before_filter :login_required
   


  def index

    @territories = Territory.where(congregation_id: session[:congid],is_checked_in: TRUE).order('checkout_date ASC').limit(8)


  
  end

  def help
    
  end

end
