class AddressesController < ApplicationController


 before_filter :login_required
 before_action :set_address, only: [:show, :edit, :update, :destroy]


  def index

   @addresses = Address.where(congregation_id: session[:congid]).paginate(:page => params[:page], :per_page => 30).order("street ASC")

   respond_to do |format|
    format.html # index.html.erb
   end

  end


  def index_street

    @street = params[:street]
    if  params[:street].to_s == ""
    @addresses = nil
    
    else
    @addresses = Address.where("street LIKE '#{@street}%' AND congregation_id = '#{session[:congid]}'").order("street,LENGTH(house_no+0),house_no,LENGTH(apt_no),apt_no") # Return only Requested street
    end


    respond_to do |format|
      format.html # index.html.erb
      
    end
  end


    def index_terr

    @territory = params[:territory_id]

    if !@territory.nil?
       session[:terr] = @territory
    end

    @addresses = Address.where(congregation_id: session[:congid], territory_id: session[:terr]).order("street,LENGTH(house_no+0),house_no,LENGTH(apt_no),apt_no") # Return only Requested street

    respond_to do |format|
      format.html # index.html.erb
    end
  end




  def index_house_number
    @house = params[:house]
    @street = params[:street]
    @apt = params[:apt]
    if @apt.nil?
      @apt = "%"
    end
    @addresses = Address.where("house_no = '#{@house}' and street = '#{@street}' and apt_no LIKE '#{@apt}' AND congregation_id = '#{session[:congid]}'") # Return only Requested street

    respond_to do |format|
      format.html # index.html.erb
     end


  end



 def what_territory

   @cities = Address.where(congregation_id: session[:congid]).select('distinct city')
   @zones = Zone.where(congregation_id: session[:congid])
   @territories =  Territory.where(congregation_id: session[:congid], zone_id: @zone).order("territory_no+0")

 end



  def what_territory_post

  @cities = Address.where(congregation_id: session[:congid]).select('distinct city')
  @house_no = params[:house_no]
  @street = params[:street]
  @city = params[:city].to_s
  @state = params[:state]
  @zone = params[:zone1]
  @zones = Zone.where(congregation_id: session[:congid])
  @territories =  Territory.where(congregation_id: session[:congid], zone_id: @zone).order("territory_no+0")

  respond_to do |format|

    if @street.blank?
     format.js { render partial: 'layouts/no_street' }
    else
     format.js
    end

  end

  end






  
  def show
    @map = User.find_by(username: session[:username]).mappref
    @zoom = 13

    respond_to do |format|
      format.html # show.html.erb
    end

  end



  def new_from_street
    @house_no = params[:house_no]
    @street = params[:street]
    @city = params[:city]
    @address = params[:address]
    @neighborhood = params[:neighborhood]
    @zip = params[:zip]
    @state = params[:state]

    @householder = Householder.new
    #See create below.. if the user puts in a name it create the hh object.
    @address = Address.new


    respond_to do |format|
      format.html # new.html.erb
     end
  end


def show_all_cords

  @street = params[:street]
  @address = params[:address]
  @map = User.find_by(username: session[:username]).mappref
  @addresses = Address.where(congregation_id: session[:congid], address_id: @address, street: @street).where.not(coordinate: '')
       respond_to do |format|
      format.html # new.html.erb
     end
end

  def new

    @territory = Territory.find(params[:territory_id])
    if !@territory.center_coordinate.blank?
      @coordinate = @territory.center_coordinate
    end

    #See create below.. if the user puts in a name it create the hh object.
    @address = Address.new
    @address.householders.build
    @cong = Congregation.find(session[:congid])
    @city = Congregation.find(session[:congid]).city
    @state = Congregation.find(session[:congid]).state
      respond_to do |format|

      format.html # new.html.erb      
     end
  end


  def edit

  end
 
  def create

    @address = Address.new(address_params)
    

    if @address.territory_id.blank?
      redirect_to :back
    else
    
    respond_to do |format|

      if @address.save
         format.html { redirect_to controller: 'addresses', action: 'show',id: @address.id, notice: "#{t :address_created}" }

      else
         format.html { render :action => "new" }

      end
    end


    end
  end

  # PUT /addresses/1
  # PUT /addresses/1.xml
  
  def update

    respond_to do |format|
      if @address.update(address_params)
        flash[:notice] = 'Address was successfully updated.'
        format.html { redirect_to(@address) }

      else
        format.html { render :action => "edit" }

      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.xml
  def destroy

   @address.destroy
   @addresses = Address.where(congregation_id: session[:congid],territory_id: @address.territory_id, street: @address.street).where.not(house_no: @address.house_no).order("house_no")

  if  Congregation.find(session[:congid]).is_coordinate_only == true
    if @addresses.count > 0

        @addresses.each_with_index do |address, index|
        index2 = index + 1
        @addresses[index].house_no = index2
        @addresses[index].save
        index+1
        end

    end
  end
   

    respond_to do |format|
      format.html { redirect_to :back }
     end
  end



  def home

   
  end





  def edit_alt
    @address = Address.find_by(id: params[:aid], congregation_id: session[:congid])
  end



  def remove_alt

      @address = Address.find_by(id: params[:aid],congregation_id: session[:congid])
      @address.alt_city = nil
      @address.alt_house_no = nil
      @address.alt_street = nil
      @address.save
      flash[:notice] = "#{t :removed_alt_address}"
      redirect_to :back

  end



  def export
      require 'csv'
      @addresses =  Address.where("addresses.congregation_id = '#{session[:congid]}'").includes(:territory).order("addresses.territory_id ASC,addresses.street,addresses.house_no,LENGTH(addresses.apt_no),addresses.apt_no") # Return only Requested street

      @outfile = "address_backup_" + Time.now.strftime("%m-%d-%Y") + ".csv"

  csv_data = CSV.generate do |csv|
    csv << [
    "Neighborhood",
    "House Number",
    "Street",
    "Apartment",
    "City",
    "State",
    "zip",
    "Territory"
    ]
    @addresses.each do |address|
      csv << [
      address.neighborhood,
      address.house_no,
      address.street,
      address.apt_no,
      address.city,
      address.state,
      address.zip,
      address.territory.territory_no

      ]
    end


    end

 send_data csv_data,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=#{@outfile}"


  end


 private
  # Use callbacks to share common setup or constraints between actions.
 def set_address
   @address = Address.find_by(id: params[:id], congregation_id: session[:congid])
 end

  # Never trust parameters from the scary internet, only allow the white list through.
 def address_params
   params.require(:address).permit(:neighborhood, :house_no,:street, :apt_no, :city, :state, :zip, :call_date, :territory_id, :congregation_id, householders_attributes: [:fname, :lname, :address_id, :congregation_id, :call_date ])
 end

end
