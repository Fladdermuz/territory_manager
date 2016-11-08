class ClientsController < ApplicationController
     before_filter :login_required, only: [:refresh_map,:show, :index,:update, :destroy, :edit]
     before_action :set_client, only: [:refresh_map,:show, :edit, :update, :destroy]
     before_action :setup, only: [:index, :update]


  def index

    if is_admin
    @clients = Client.all
    respond_to do |format|
      format.html # index.html.erb
     end
    else
     redirect_to current_user.client
    end



  end


  def refresh_map

    @coordinates = params[:coordinate]
    @client.coordinate = @coordinates
    @client.save

    respond_to do |format|
      format.js
     end

  end


  def show



    @country =  @client.country


   if @client.coordinate.blank? || @client.coordinate == "38.802859, -96.208728"
    @coordinates = @country.latitude.to_s + "," + @country.longitude.to_s
   else
    @coordinates = @client.coordinate
   end


    respond_to do |format|
      format.html # show.html.erb
     end
  end



  def new
    @client = Client.new
    @client.users.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end


  def edit
    @client = Client.find(params[:id])
  end


  def create
    @client = Client.new(client_params)


    respond_to do |format|
      if @client.save
         @username = nil
       client_params[:users_attributes].values.each do |item|
         @username = item[:username]
         @password = item[:password]
       end

        if !@username.nil?
          @user = User.find_by(username: @username)

          if @user.nil?
          else
           UserMailer.send_user(@user,@password).deliver_now
           session[:user] = @user
           session[:uid] = @user.id
           session[:username] = @username
           session[:role] = "admin"
           session[:client_id] =  @client.id
           session[:locale] = @user.sitelang
          end
        end

        format.html { redirect_to @client}

       else
        format.html { render :action => "new" }
       end
    end
  end


  def update

    respond_to do |format|
      if @client.update(client_params)
        flash[:notice] = 'Client was successfully updated.'
        format.html { redirect_to(@client) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy

    @client.destroy

    respond_to do |format|
      format.html { redirect_to(clients_url) }
      format.xml  { head :ok }
    end
  end

     private
  # Use callbacks to share common setup or constraints between actions.
     def set_client
       @client = Client.find_by(id: params[:id])
     end

  # Never trust parameters from the scary internet, only allow the white list through.
     def client_params
       params.require(:client).permit(:zip, :is_coordinate_only, :coordinate, :name, :address, :city, :state, :country_id, :language, users_attributes: [:id, :isadmin, :username, :fname, :lname, :password, :client_id, :email])
     end

end
