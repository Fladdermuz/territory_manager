require 'digest/md5'

class LoginController < ApplicationController

  layout "home"

  def index
    @user = User.new
  end


  def login


     @ip = request.remote_ip
     if request.post?

       if session[:user] = User.authenticate(params[:user][:username], params[:user][:password])

        @uname = params[:user][:username]
        @user = User.find_by(username: @uname)
        session[:uid] = @user.id
        session[:username] = @uname
        session[:map_layer_id] = 1

        if @user.isadmin
          session[:role] = "admin"
        end
        if @user.can_manage_hh
          session[:role] = "hh_admin"
        end


        session[:client_id] = @user.client_id # Store the users client in session
        session[:locale] = @user.sitelang
        redirect_to_stored



      else
         Rails.logger.info "The User was not Authenticated"


        render "login/unauthorized"
      end
    end

  end

  def logout
    session[:user] = nil
    reset_session
    Rails.logger.info "#{self.controller_name}:#{self.action_name}: Logged out User"
    redirect_to :controller => "login"
  end



end
