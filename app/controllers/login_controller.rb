require 'digest/md5'

class LoginController < ApplicationController
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
        if @user.isadmin
          session[:role] = "admin"
        end

        if @user.iscongadmin
          session[:role] = "congadmin"
        end


        session[:congid] = @user.congregation_id # Store the users cong in session
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