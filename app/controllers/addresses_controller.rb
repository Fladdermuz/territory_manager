class AddressesController < ApplicationController


 before_action :login_required
 before_action :set_address, only: [:refresh_map,:show, :edit, :update, :destroy]
 before_action :setup


  def index

   @addresses = Address.where(client_id: session[:client_id]).paginate(:page => params[:page], :per_page => 30).order("street ASC")

   respond_to do |format|
    format.html # index.html.erb
   end

  end


  def index_street

    @street = params[:street]
    if  params[:street].to_s == ""
    @addresses = nil

    else
    @addresses = Address.where("street LIKE '#{@street}%' AND client_id = '#{session[:client_id]}'").order("street,LENGTH(house_no+0),house_no,LENGTH(apt_no),apt_no") # Return only Requested street
    end


    respond_to do |format|
      format.html # index.html.erb

    end
  end


    def index_terr

     @territory_id = params[:territory_id]
     @territory = Territory.find(@territory_id)
     @addresses = Address.where(client_id: session[:client_id], territory_id: @territory_id).order("street,LENGTH(house_no+0),house_no,LENGTH(apt_no),apt_no") # Return only Requested street

      respond_to do |format|
        format.html # index.html.erb
      end

    end




 def what_territory

   @zones = Zone.where(client_id: session[:client_id])
   @territories = nil

 end



  def what_territory_post

  @house_no = params[:house_no]
  @street = params[:street]
  @city = params[:city].to_s
  @state = params[:state]

  @house_no = '259'
  @street = 'Laurel Lane'
  @city = 'Carrollton'
  @state = 'Ga'

  @cord = Geocoder.coordinates("#{@house_no}, #{@street}, #{@city},#{@state}")
  @coords = @cord[0].to_s + ',' + @cord[1].to_s

  @terr_hash = Hash.new(0)

  @territories_unsorted =  Territory.where(client_id: session[:client_id]).order("territory_no+0")

  @territories_unsorted.each do |t|
   @terr_hash[t.id] = Geocoder::Calculations.distance_between(@coords, t.center_coordinate)
  end


  @territories = @terr_hash.sort_by { |key, value| value }


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

     if @address.center_coordinate.blank?
       @coordinates = @address.latitude.to_s + "," + @address.longitude.to_s
     else
       @coordinates = @address.center_coordinate
     end


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
  @addresses = Address.where(client_id: session[:client_id], address_id: @address, street: @street).where.not(center_coordinate: '')
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
    @client = Client.find(session[:client_id])
    @city = Client.find(session[:client_id]).city
    @state = Client.find(session[:client_id]).state
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
         format.html { redirect_to controller: 'addresses', action: 'show',id: @address.id }

      else
         format.html { render :action => "new" }

      end
    end


    end
  end


    def refresh_map

      @coordinates = params[:coordinate]
      @address.center_coordinate = @coordinates
      @address.save

      respond_to do |format|
        format.js
       end

    end




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
   @addresses = Address.where(client_id: session[:client_id],territory_id: @address.territory_id, street: @address.street).where.not(house_no: @address.house_no).order("house_no")

  if  Client.find(session[:client_id]).is_coordinate_only == true
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
      format.html { redirect_to controller: 'addresses' }
     end
  end



  def home


  end







  def export
      require 'csv'
      @addresses =  Address.where("addresses.client_id = '#{session[:client_id]}'").includes(:territory).order("addresses.territory_id ASC,addresses.street,addresses.house_no,LENGTH(addresses.apt_no),addresses.apt_no") # Return only Requested street

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
   @address = Address.find_by(id: params[:id], client_id: session[:client_id])
 end

  # Never trust parameters from the scary internet, only allow the white list through.
 def address_params
   params.require(:address).permit(:neighborhood, :center_coordinate, :house_no,:street, :latitude, :longitude, :apt_no, :city, :state, :zip, :call_date, :territory_id, :client_id, householders_attributes: [:fname, :lname, :address_id, :client_id, :call_date ])
 end

end
