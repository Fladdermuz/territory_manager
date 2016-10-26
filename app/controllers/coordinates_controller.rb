class CoordinatesController < ApplicationController
  before_filter :set_coordinate, only: [:destroy]
  before_action :setup

  def new

    if params[:auto_submit].to_s == '1'
      @auto_submit = TRUE
    else
      @auto_submit = FALSE
    end


    @territory_id = params[:territory_id]
    @coordinate = Coordinate.new
    @territory = Territory.find(@territory_id)

    respond_to do |format|
      format.html
     end
  end


    def new_zone

      if params[:auto_submit].to_s == '1'
        @auto_submit = TRUE
      else
        @auto_submit = FALSE
      end

      @zone_id = params[:zone_id]
      @coordinate = Coordinate.new
      @zone = Zone.find_by(id: @zone_id)

      respond_to do |format|
        format.html
       end
    end




  def create
    @coordinate = Coordinate.new(coordinate_params)

    respond_to do |format|
      if @coordinate.save
        @msg = "#{t :coordinate}" + "#{t :record_created}"
        flash[:cord_notice] = @msg
        format.html { redirect_to :back }
       else
        format.html { render :action => "new" }
       end
    end
  end



  def destroy
    @coordinate = Coordinate.find(params[:id])
    @coordinate.destroy
    @msg = "#{t :coordinate}" + "#{t :record_deleted}"
    flash[:cord_notice] = @msg
    respond_to do |format|
      format.html { redirect_to(coordinates_url) }
      format.xml  { head :ok }
    end
  end




    private
  # Use callbacks to share common setup or constraints between actions.
    def set_coordinate
      @coordinate = Coordinate.find(params[:id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def coordinate_params
      params.require(:coordinate).permit(:territory_id, :coordinate, :zone_id)
    end



end
