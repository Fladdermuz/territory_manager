class MapLayersController < ApplicationController
  before_action :set_map_layer, only: [:show, :edit, :update, :destroy]
  before_action :check_client, only: [:show, :edit, :update, :destroy]


  def index
    @map_layers = MapLayer.order(:name)
  end


  def set_layer
    session[:map_layer_id] = params[:map_layer_id]

    if params[:territory_id]
       @territory = Territory.find_by(id: params[:territory_id])
      if @territory.nil?
      else
        @territory.map_layer_id = params[:map_layer_id]
        @territory.save
      end
    end

    if params[:address_id]
       @address = Address.find_by(id: params[:address_id])
      if @address.nil?
      else
        @address.map_layer_id = params[:map_layer_id]
        @address.save
      end
    end

    if params[:zone_id]
       @zone = Zone.find_by(id: params[:zone_id])
      if @zone.nil?
      else
        @zone.map_layer_id = params[:map_layer_id]
        @zone.save
      end
    end

    redirect_to :back
   end



  def create
    @map_layer = MapLayer.new(map_layer_params)

    respond_to do |format|
      if @map_layer.save
        @message = "#{t :map_layer}" + " #{t :record_created}"
        @title = "#{t :map_layers}"
        @map_layers = MapLayer.order(:name)
        format.js
      else
        @errors = @map_layer.errors.full_messages
        format.js
      end
    end
  end


  def update
    respond_to do |format|
      if @map_layer.update(map_layer_params)
        @message = "#{t :map_layer}" + " #{t :record_updated}"
        @title = "#{t :map_layers}"
        format.js
      else
        @errors = @map_layer.errors.full_messages
        format.js
      end
    end
  end


  def destroy
    @map_layer.destroy
    @map_layers = MapLayer.order(:name)
    @message = "#{t :map_layer}" + " #{t :record_deleted}"
    @title = "#{t :map_layers}"
    respond_to do |format|
      @errors = @map_layer.errors.full_messages
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_map_layer
    @map_layer = MapLayer.find(params[:id])
  end

  def check_client
    is_same_client_redirect(@map_layer)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def map_layer_params
    params.require(:map_layer).permit(:name, :max_zoom, :min_zoom, :layer_url, :provider, :api_key, :is_mapbox, :map_type, :file_ext, :subdomains)
  end
end
