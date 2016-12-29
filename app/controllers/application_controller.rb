# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_action :set_locale
  helper_method :is_same_client
  helper_method :is_same_client_redirect
  helper_method :current_user
  helper_method :is_admin
  helper_method :is_client_admin
  helper_method :setup
  helper_method :check_in_terr
  helper_method :is_any_admin_redirect
  helper_method :is_any_admin
  helper_method :can_manage_addresses




  def can_manage_addresses_redirect

     if is_admin || is_client_admin || current_user.can_manage_hh?
     else
       respond_to controller: 'main'
     end

  end

  def is_any_admin_redirect

   if is_admin || is_client_admin
   else
     redirect_to controller: 'main'
   end


  end

  def is_any_admin
   @is_any_admin = FALSE

   if is_admin || is_client_admin
       @is_any_admin = TRUE
   end

   return  @is_any_admin

  end


  def check_in_terr(territory)

    territory.is_checked_in = true
    territory.last_worked = Date.today
    territory.user_id = nil
    territory.view_key = nil
    territory.check_back_in = nil
    territory.save!

    @History = TerritoryHistory.where(territory_id: territory.id, client_id: session[:client_id])
    if !@History[0].nil? && !@History[0].check_in_date.blank?
       @History[0].check_in_date = Date.today
       @History[0].save
    end



  end



  def setup

    if current_user.nil? || !current_user.isadmin? && !current_user.is_client_admin? && !current_user.can_manage_hh?
      redirect_to  :logout
    else
     @u = current_user

     if @u.must_change_pass?
       flash[:notice] = 'Your Must Change your password!'
       redirect_to controller: 'users', action: 'edit', id: current_user.id
     else

      if @u.client.center_coordinate == "38.802859, -96.208728" && session[:role].to_s != 'admin'
       redirect_to controller: "clients", action: "edit", id: @u.client_id
      else

         if session[:role].to_s == 'admin' && current_user.email == 'blank'
          redirect_to controller: "users", action: "edit", id: current_user.id
         end

      end
     end


    end


  end


  def is_client_admin
  @is_client_admin = FALSE

   if session[:role].to_s == "client_admin"
     @is_client_admin = TRUE
   end

   return @is_client_admin
  end


  def is_admin
  @is_admin = FALSE

   if session[:role].to_s == "admin"
    @is_admin = TRUE
   end

   return @is_admin

  end

    def current_user

     if session[:uid]
     @current_user = User.find_by(id: session[:uid])
     if @current_user.nil?
      session[:uid] = nil
     end
     end


     return @current_user

    end


    def is_same_client(object)

      @same_test = FALSE

      if is_admin
        @same_test = TRUE
      else

        if object.client_id == current_user.client_id
          @same_test = TRUE
        end

      end


      return @same_test


    end


    def is_same_client_redirect(object)

      @same_test = is_same_client(object)

      if @same_test
      else
        redirect_to controller: 'main', action: 'no_perms'
      end

      return @same_test

    end


 def set_locale # if params[:locale] is nil then I18n.default_locale will be used
     I18n.locale = session[:locale]
 end


  def login_required
     if session[:user]
     return true
    else
      redirect_to :controller => "login"
    return false
  end
  end


def isadminuser
  if session[:role] == "admin" or  session[:role] == "admin"
   return true
  else
   redirect_to :controller => "main"
   return false
  end
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
