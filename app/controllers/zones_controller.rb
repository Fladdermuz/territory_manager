class ZonesController < ApplicationController

   before_action :set_zone, only: [:clear_coordinates, :clear_last_coordinate, :edit, :destroy, :update_zoom, :update, :show]
   before_action :check_client, only: [:edit, :show, :update, :destroy]
   before_action :setup

  def index

 
    @zones = Zone.where(client_id: current_user.client_id)

    respond_to do |format|
      format.html # index.html.erb
     end
  end



 def update_zoom

   @zone.zoom = params[:zone][:zoom]
   @zone.save
   respond_to do |format|
       flash[:zone_notice] = 'Zone was successfully updated.'
       format.html { redirect_to controller: 'coordinates', action: 'new_zone', zone_id: @zone.id}
   end


 end




  def show

  end


  def new
    @zone = Zone.new

  end


  def edit

  end


  def clear_coordinates

    @Coordinates = Coordinate.where(zone_id: @zone.id)

    @Coordinates.each do |coord|
       coord.delete
    end

    redirect_to :controller=>"coordinates",:action => "new_zone",:zone_id=> @zone.id

  end

  def clear_last_coordinate

    @Coordinates = Coordinate.where(zone_id: @zone.id).order("id ASC")
    @Count = @Coordinates.count -1
    @Coordinates.last.delete

    redirect_to :controller=>"coordinates",:action => "new_zone",:zone_id=> @zone.id

  end


  def create
    @zone = Zone.new(zone_params)

    respond_to do |format|
      if @zone.save
        @msg = "#{t :zone}" + "#{t :record_created}"
        flash[:zone_notice] = @msg
        format.html { redirect_to(@zone) }
       else
         @errors = @zone.errors.full_messages
         flash[:zone_notice] = @errors
        format.html { render :action => "new" }
       end
    end
  end


  def update

    respond_to do |format|
      if @zone.update_attributes(zone_params)
        @msg = "#{t :zone}" + "#{t :record_updated}"
        flash[:zone_notice] = @msg
        format.html { redirect_to(@zone) }
       else
        format.html { render :action => "edit" }
       end
    end
  end


  def destroy
      respond_to do |format|
        if @zone.destroy
      format.html { redirect_to(zones_url) }
         else
           @msg = "#{t :zone}" + "#{t :record_deleted}"
           flash[:zone_notice] = @msg
         format.html { redirect_to(:back) }
        end
    end
  end

   private
  # Use callbacks to share common setup or constraints between actions.
   def set_zone
     @zone = Zone.find_by(id: params[:id], client_id: current_user.client_id)
   end

   def check_client
     is_same_client_redirect(@zone)
   end

  # Never trust parameters from the scary internet, only allow the white list through.
   def zone_params
     params.require(:zone).permit(:zone_no, :city, :state, :country_id, :description, :client_id, :center_coordinate, :zoom, :fill_color, :border_size,:border_color, :map_layer_id)
   end






end
