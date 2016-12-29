class ClientsController < ApplicationController
     before_action :login_required, only: [:refresh_map,:show, :index,:update, :destroy, :edit]
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
    @client.center_coordinate = @coordinates
    @client.save

    respond_to do |format|
      format.js
     end

  end


  def show


    if @client.id.to_s == current_user.client_id.to_s || is_admin

    @country =  @client.country


     if @client.latitude.blank? && @client.longitude.blank?
      @coordinates = @country.latitude.to_s + "," + @country.longitude.to_s
     else

       if @client.latitude.blank? && @client.longitude.blank?
        @coordinates = @client.center_coordinate
       else
        @coordinates = @client.latitude.to_s + ',' + @client.longitude.to_s
       end



     end


    respond_to do |format|
      format.html # show.html.erb
     end

    else
     redirect_to controller: 'main'
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

    if @client.id.to_s == current_user.client_id.to_s || is_admin
     @client = Client.find(params[:id])
    else
      redirect_to controller: "main"
    end

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
           session[:role] = "client_admin"
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
       params.require(:client).permit(:zip, :is_language_based, :is_coordinate_only, :latitude, :longitude, :center_coordinate , :name, :address, :city, :state, :country_id, :language, users_attributes: [:id, :sitelang, :is_client_admin, :username, :fname, :lname, :password, :client_id, :email])
     end

end
