class UsersController < ApplicationController

     before_filter :login_required,:isadminuser

  # GET /users
  # GET /users.xml
  def index


    if session[:role] == "admin"
    @users = User.includes(:congregation).order(:username)
    end

    if session[:role] == "congadmin"
       @users = User.where(congregation_id: session[:congid])
    end

    if  session[:role].nil?
     render "main/index"
     else

    end
    
  end

  # GET /users/1
  # GET /users/1.xml
  def show

    if session[:role] == "admin"
    @user = User.find(params[:id])

        respond_to do |format|
          format.html # show.html.erb
         end
    end


    if session[:role] == "congadmin"
    @user = User.find_by(id: params[:id],congregation_id: session[:congid])

        respond_to do |format|
          format.html # show.html.erb
        end

    end






  end





  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
     end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @map = @user.mappref
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }

      else
        format.html { render :action => "new" }
       end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
       else
        format.html { render :action => "edit" }
       end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
     end
  end
end
