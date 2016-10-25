class ZonesController < ApplicationController
   before_filter :login_required,:isadminuser
   before_action :set_zone, only: [:edit, :destroy, :update, :show]

  def index
    @zones = Zone.where(congregation_id: session[:congid])

    respond_to do |format|
      format.html # index.html.erb
    end
  end


  def show

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @zone = Zone.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit

  end


  def create
    @zone = Zone.new(zone_params)

    respond_to do |format|
      if @zone.save
        flash[:notice] = 'Zone was successfully created.'
        format.html { redirect_to(@zone) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update

    respond_to do |format|
      if @zone.update_attributes(zone_params)
        flash[:notice] = 'Zone was successfully updated.'
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
         flash[:znotice] = 'Can not delete Zone with Territories still in it.'
         format.html { redirect_to(:back) }
        end
    end
  end

   private
  # Use callbacks to share common setup or constraints between actions.
   def set_zone
     @zone = Zone.find_by(id: params[:id], congregation_id: session[:congid])
   end

  # Never trust parameters from the scary internet, only allow the white list through.
   def zone_params
     params.require(:zone).permit(:zone_no, :descrip, :img_url, :congregation_id)
   end






end
