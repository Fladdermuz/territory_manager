class TerritoriesController < ApplicationController
   before_filter :login_required, :isadminuser
   before_filter :set_territory, only: [:check_in,:check_out_new_user, :check_out, :check_out_post,:clear_last_coordinate, :clear_coordinates, :show, :edit, :update, :destroy,:view_all_ter_pins,:view_ter_householders]
   before_action :setup


  def index
    @territories= Territory.where(client_id: session[:client_id]).paginate(:page => params[:page], :per_page => 30).order("territory_no+0") # Return only Requested street
    respond_to do |format|
      format.html # index.html.erb
     end
  end


    def index_zone

      @zone_id = params[:zoneid]
      @territories= Territory.where(client_id: session[:client_id], zone_id: @zone_id).paginate(:page => params[:page], :per_page => 30).order("territory_no+0") # Return only Requested street

      respond_to do |format|
        format.html # index.html.erb
      end

    end




  def show
     @bordercount = 0
  end


  def new
    @zone = Zone.find(params[:zone_id])
    @territory = Territory.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end



  def edit

  end



  def create
    @territory = Territory.new(territory_params)

    respond_to do |format|
      if @territory.save


        flash[:tnotice] = 'Territory was successfully created.'
        format.html { redirect_to(@territory) }


      else
        @zone = @territory.zone
        format.html { render :action => "new"}
      end
    end
  end





  def update

    respond_to do |format|
      if @territory.update(territory_params)
        flash[:tnotice] = 'Territory was successfully updated.'
        format.html { redirect_to(@territory) }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
    @territory = Territory.find_by(id: params[:id],client_id: session[:client_id])

    respond_to do |format|
     if @territory.destroy
      format.html { redirect_to(territories_url) }
     else
      flash[:dnotice] = 'Territory can not be deleted while it has addresses.'
      format.html { redirect_to(:back) }

     end
    end
  end



    def view_ter_householders_coords
    #a printout of this is what is given to publishers to take out in service.
    @territory_id = params[:territory_id]
    @territory = Territory.find(@territory_id)

    @addresses = Address.where(territory_id: @territory_id,client_id: session[:client_id]).order("street,LENGTH(house_no+0),house_no,LENGTH(apt_no),apt_no")
    @addresses2 = Address.where(territory_id: @territory_id, client_id: session[:client_id]).where.not("coordinate is not null").order("street,LENGTH(house_no+0),house_no,LENGTH(apt_no),apt_no")
    @street = Address.where(territory_id: @territory_id, client_id: session[:client_id]).where.not("coordinate is not null").order("street,LENGTH(house_no+0),house_no,LENGTH(apt_no),apt_no")
    @map = User.find_by(username: session[:username]).mappref
    @zoom = 17
    @colors = Array.new
    @colors << 'grey'
    @colors << 'blue'
    @colors << 'green'
    @colors << 'yellow'
    @colors << 'red'
    @colors << 'black'
    @colors << 'purple'
    @colors << 'orange'
    @colors << 'grey'
    @colors << 'blue'
    @colors << 'green'
    @colors << 'yellow'
    @colors << 'red'
    @colors << 'black'
    @colors << 'purple'
    @colors << 'orange'
    @colors << 'white'
    @colors << 'blue'
    @colors << 'green'
    @colors << 'yellow'
    @colors << 'red'
    @colors << 'black'
    @colors << 'purple'
    @colors << 'orange'

    if @map == "satellite"
    @zoom = 18
    end
    end


  def view_all_ter_pins
    #a printout of this is what is given to publishers to take out in service.
    @addresses = Address.where(territory_id: @territory.id, client_id: session[:client_id]).paginate(:page => params[:page], :per_page => 30).order("street,house_no")
  end



  def view_all_ter_pins_with_phones
    #a printout of this is what is given to publishers to take out in service.
    @territory_id = params[:territory_id]
    @addresses = Address.where(client_id: session[:client_id]).paginate(:page => params[:page], :per_page => 30).order("street,LENGTH(house_no),house_no")
  end



   def check_out
    @user = User.new
    session[:referrer] = request.referrer
   end


    def check_out_new_user

      @user = User.new
      @user.username = params[:username]
      @user.fname = params[:fname]
      @user.lname = params[:lname]
      @user.email = params[:email]
      @user.can_manage_hh = params[:can_manage_hh]
      @user.isadmin = params[:is_admin]
      @user.client_id = current_user.client_id
      @encryptedPass = Digest::MD5.hexdigest(params[:username]+'1914');
      @user.password = @encryptedPass


      respond_to do |format|
        if @user.save

          @territory.user_id = @user.id
          @territory.is_checked_in = false
          @D = Date.today
          @territory.checkout_date = @D
          @territory.check_back_in = params[:checkin_date2]

          if @territory.save
            if !@territory.user.isadmin && !@territory.user.can_manage_hh
            UserMailer.send_terr(@user,@territory).deliver_now
            end
          end

          @History = TerritoryHistory.new
          @History.territory_id = @territory.id
          @History.check_out_date =   @D
          @History.client_id = session[:client_id]
          @History.user_id = @user_id
          @History.save

          format.html { redirect_to  session[:referrer] }
        else
          @errors = @user.errors
          format.html { render :check_out }
        end
      end

    end



    def check_out_post
      require 'chronic'

      if params[:cob]
      flash[:tnotice] = "#{t :checked_out_success}"
      @user_id = params[:cob]
      @user = User.find_by(id: @user_id)
      @territory.user_id = @user_id
      @territory.is_checked_in = false
      @D = Date.today
      @territory.checkout_date = @D
      @t = Chronic.parse(params[:checkin_date].to_s, :guess => true)

      @territory.checkin_date = @t.to_date

      if @territory.save

        if !@territory.user.isadmin && !@territory.user.can_manage_hh
         UserMailer.send_terr(@user,@territory).deliver_now
        end

      end

      @History = TerritoryHistory.new
      @History.territory_id = @territory.id
      @History.check_out_date =   @D
      @History.client_id = session[:client_id]
      @History.user_id = @user_id
      @History.save
      redirect_to  session[:referrer]

      else
       @t =  params[:id]

      end

    end


    def check_in

      flash[:tnotice] = "#{t :checked_in_success}"

      @territory.is_checked_in = true
      @territory.last_worked = Date.today
      @territory.user_id = nil
      @territory.save!

      @History = TerritoryHistory.where(territory_id: @territory.id, client_id: session[:client_id])
      if !@History[0].nil? && !@History[0].check_in_date.blank?
         @History[0].check_in_date = Date.today
         @History[0].save
      end

      redirect_to :controller =>"territories", action: 'show', id: @territory.id


    end




    def home


    end




    def report
      @territories = Territory.where(client_id: session[:client_id]).order("territory_no+0")

    end


    def report_status
      @territories = Territory.where(:all,:conditions => "client_id = '#{session[:client_id]}'", :order => "is_checked_in")

    end

    def report_cob
      @territories = Territory.where("user_id != '' and is_checked_in = false AND client_id = '#{session[:client_id]}'").order("user_id")

    end


     def report_co_date
      @territories = Territory.where("checkout_date != '' AND client_id = '#{session[:client_id]}' ").order("checkout_date")

    end


    def report_last_worked
      @territories = Territory.where("last_worked != '' AND client_id = '#{session[:client_id]}'").order("last_worked ASC")
    end




    def notfound

    end




def clear_coordinates

  @Coordinates = Coordinate.where(territory_id: @territory.id)

  @Coordinates.each do |coord|
     coord.delete
  end

  redirect_to :controller=>"coordinates",:action => "new",:territory_id=> @territory.id

end

def clear_last_coordinate

  @Coordinates = Coordinate.where(territory_id: @territory.id).order("id ASC")
  @Count = @Coordinates.count -1

  @Coordinates.last.delete unless @Coordinates.count < 1


  redirect_to :controller=>"coordinates",:action => "new",:territory_id=> @territory.id

end

   private
  # Use callbacks to share common setup or constraints between actions.
   def set_territory
     @territory = Territory.find_by(id: params[:id], client_id: session[:client_id])
   end

  # Never trust parameters from the scary internet, only allow the white list through.
   def territory_params
     params.require(:territory).permit(:check_back_in, :view_key, :center_coordinate,:zoom, :fill_color, :border_color,:map_layer_id, :territory_no, :descrip,:notes, :image, :zone_id, :last_worked, :border_size, :checkin_date, :checkout_date, :user_id, :is_checked_in, :client_id)
   end


end
