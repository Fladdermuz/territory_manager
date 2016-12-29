class UsersController < ApplicationController

   before_action :login_required
   before_action :set_user, only: [:show, :update, :destroy, :edit]


  def index

    is_any_admin_redirect

    if session[:role] == "admin"
    @users = User.includes(:client).order(:username)
    end

    if session[:role] == "client_admin"
       @users = User.where(client_id: session[:client_id])
    end

    if  session[:role].nil?
     render "main/index"
     else

    end

  end



  def show


    if session[:role] == "admin"
    @user = User.find(params[:id])

        respond_to do |format|
          format.html # show.html.erb
         end
    end


  end


  def new

    if is_admin || is_client_admin
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
     end
    end

  end


  def edit
  
  end



  def create

  if is_admin || is_client_admin
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        UserMailer.send_user(@user,@password).deliver_later
      else
        format.html { render :action => "new" }
      end
    end
  end
  end


  def update

    respond_to do |format|
      if @user.update(user_params)
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy

    if is_admin || is_client_admin

    @user.destroy
    respond_to do |format|
      format.html { redirect_to(users_url) }
     end

    end


  end


  private
 # Use callbacks to share common setup or constraints between actions.
  def set_user

    if is_admin
    @user = User.find_by(id: params[:id])
    else

      if is_client_admin
         @user = User.find_by(id: params[:id], client_id: current_user.client_id)
      else
         @user = User.find_by(id: current_user.id)
      end

    end


  end

 # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit( :is_client_admin, :must_change_pass, :username, :can_manage_hh, :password, :fname, :lname, :email, :client_id, :isadmin, :lastlogin, :sitelang)
  end






end
