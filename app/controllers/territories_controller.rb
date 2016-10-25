class TerritoriesController < ApplicationController
   before_filter :login_required,:isadminuser
   before_filter :set_territory, only: [:show, :edit, :update, :destroy]


   # GET /territories
  # GET /territories.xml
  def index
    @territories= Territory.where(congregation_id: session[:congid]).paginate(:page => params[:page], :per_page => 30).order("territory_no+0") # Return only Requested street
    respond_to do |format|
      format.html # index.html.erb      
     end
  end


    def index_zone

   @zoneid = params[:zoneid]
   @territories= Territory.where(congregation_id: session[:congid], zone_id: @zoneid).order("territory_no+0") # Return only Requested street
    respond_to do |format|
      format.html # index.html.erb
     end
  end




  def show
     @bordercount = 0
  end


  def new
    @territory = Territory.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

    def new_dynamic
    @territory = Territory.new 
    

    respond_to do |format|
      format.html 
    end
  end


  def new_dynamic_centered
    @territory = Territory.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  
  # GET /territories/1/edit
  def edit

  end

  # POST /territories
  # POST /territories.xml
  def create
    @territory = Territory.new(territory_params)

    respond_to do |format|
      if @territory.save

        if request.referer == "http://localhost:3000/territories/new_dynamic" || request.referer == "http://ministrymanager2414.org/territories/new_dynamic"
        format.html { redirect_to :controller=>"coordinates",:action=>"new",:territoryid=>@territory.id }
        else
        flash[:tnotice] = 'Territory was successfully created.'
        format.html { redirect_to(@territory) }
        end

      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /territories/1
  # PUT /territories/1.xml
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

  # DELETE /territories/1
  # DELETE /territories/1.xml
  def destroy
    @territory = Territory.find_by(id: params[:id],congregation_id: session[:congid])
   
    respond_to do |format|
     if @territory.destroy
      format.html { redirect_to(territories_url) }
     else
      flash[:dnotice] = 'Territory can not be deleted while it has addresses.'
      format.html { redirect_to(:back) }

     end
    end
  end

  def view_ter_householders
    #a printout of this is what is given to publishers to take out in service.
    @territory_id = params[:territory_id]
    @territory = Territory.find(@territory_id)
    @territory.reserved_by = session[:username]
    @territory.isreserved = true
    @territory.save
    @addresses = Address.where(territory_id: @territory_id,congregation_id: session[:congid]).order("street,LENGTH(house_no+0),house_no,LENGTH(apt_no),apt_no")

    @map = User.find_by(username: session[:username]).mappref
    @zoom = 15
    if @map == "satellite"
    
    end
  end

    def view_ter_householders_coords
    #a printout of this is what is given to publishers to take out in service.
    @territory_id = params[:territory_id]
    @territory = Territory.find(@territory_id)
    @territory.reserved_by = session[:username]
    @territory.isreserved = true
    @territory.save
    @addresses = Address.where(territory_id: @territory_id,congregation_id: session[:congid]).order("street,LENGTH(house_no+0),house_no,LENGTH(apt_no),apt_no")
    @addresses2 = Address.where(territory_id: @territory_id, congregation_id: session[:congid]).where.not("coordinate is not null").order("street,LENGTH(house_no+0),house_no,LENGTH(apt_no),apt_no")
    @street = Address.where(territory_id: @territory_id, congregation_id: session[:congid]).where.not("coordinate is not null").order("street,LENGTH(house_no+0),house_no,LENGTH(apt_no),apt_no")
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
  

  def view_ter_householders_with_phones
    #a printout of this is what is given to publishers to take out in service.
    @territory_id = params[:territory_id]
    @addresses = Address.where(territory_id: @territory_id, congregation_id: session[:congid]).paginate(:page => params[:page], :per_page => 30).order("street,house_no")
  end



  def view_all_ter_householders_with_phones
    #a printout of this is what is given to publishers to take out in service.
    @territory_id = params[:territory_id]
    @addresses = Address.where(congregation_id: session[:congid]).paginate(:page => params[:page], :per_page => 30).order("street,LENGTH(house_no),house_no")
  end



   def check_out
     @t =  params[:territory_id]
   end



    def check_out_post

      if params[:cob]
      flash[:tnotice] = "#{t :checked_out_success}"
      @by = params[:cob]
      @t =  params[:territory_id]

      @Territory = Territory.find_by(id: @t, congregation_id: session[:congid])



      @Territory.checked_out_by = @by
      @Territory.is_checked_in = false
      @D = Date.today 
      @Territory.checkout_date = @D
      @Territory.isreserved = false
      @Territory.reserved_by = ""
      @Territory.save

      @History = TerritoryHistory.new
      @History.territory_id = @t
      @History.check_out_date =   @D
      @History.congregation_id = session[:congid]
      @History.checked_out_by = @by
      @History.save
       redirect_to :controller =>"territories", :action => 'show',id: @t
     
    else
   @t =  params[:territory_id]
    
    end

    end


    def check_in

      flash[:tnotice] = "#{t :checked_in_success}"
      @t =  params[:territory_id]
      @Territory = Territory.find_by(id: @t, congregation_id: session[:congid])
      @Territory.is_checked_in = true
      @Territory.last_worked = Date.today
      @Territory.checked_out_by = "Last Worked BY:" + @Territory.checked_out_by.to_s
      @Territory.save!

      @History = TerritoryHistory.where(territory_id: @t, congregation_id: session[:congid])
      if !@History[0].check_in_date.blank?
        @History[0].check_in_date = Date.today
        @History[0].save
      end

      redirect_to :controller =>"territories", action: 'show', id: @t


    end




    def home

       
    end




    def report
      @territories = Territory.where(congregation_id: session[:congid]).order("territory_no+0")

    end


    def report_status
      @territories = Territory.where(:all,:conditions => "congregation_id = '#{session[:congid]}'", :order => "is_checked_in")

    end

    def report_cob
      @territories = Territory.where("checked_out_by != '' and is_checked_in = false AND congregation_id = '#{session[:congid]}'").order("checked_out_by")

    end


     def report_co_date
      @territories = Territory.where("checkout_date != '' AND congregation_id = '#{session[:congid]}' ").order("checkout_date")

    end


    def report_last_worked
      @territories = Territory.where("last_worked != '' AND congregation_id = '#{session[:congid]}'").order("last_worked ASC")

    end



    def view_ter_image
      @imgurl = params[:imgurl]
    end


    def notfound
      
    end


   def printedque
      @territories = Territory.where(isreserved:TRUE, congregation_id: session[:congid]).order("territory_no+0")
   end


  def remove_from_que
      @terr = params[:terr]
      @territory = Territory.find(@terr)
      @territory.isreserved = false
      @territory.reserved_by = ""
      @territory.save
      redirect_to :back


  end
 
def clear_coordinates
  @territory = params[:territory]
  @Coordinates = Coordinate.where(territory_id: @territory)
  
  @Coordinates.each do |coord|
     coord.delete
  end
  
  redirect_to :controller=>"coordinates",:action => "new",:territoryid=>@territory

end

def clear_last_coordinate
  @territory = params[:territory]
  @Coordinates = Coordinate.where(territory_id: @territory).order("id ASC")
  @Count = @Coordinates.count -1
  @Coordinates.last.delete

  
  redirect_to :controller=>"coordinates",:action => "new",:territoryid=>@territory

end

   private
  # Use callbacks to share common setup or constraints between actions.
   def set_territory
     @territory = Territory.find_by(id: params[:id], congregation_id: session[:congid])
   end

  # Never trust parameters from the scary internet, only allow the white list through.
   def territory_params
     params.require(:territory).permit(:image, :is_dynamic, :center_coordinate,:zoom, :color, :border_color,:maptype, :territory_no, :descrip,:notes, :img_url, :zone_id, :last_worked, :checkout_date, :checked_out_by, :is_checked_in, :congregation_id)
   end


end
