class CoordinatesController < ApplicationController
    before_filter :login_required,:isadminuser
    before_filter :set_coordinate, only: [:destroy]
  # GET /coordinates
  # GET /coordinates.xml
 
  # GET /coordinates/new
  # GET /coordinates/new.xml
  def new
    @territoryid = params[:territoryid]
    @coordinate = Coordinate.new
    @territory = Territory.find(@territoryid)


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @coordinate }
    end
  end

  # GET /coordinates/1/edit

  # POST /coordinates
  # POST /coordinates.xml
  def create
    @coordinate = Coordinate.new(coordinate_params)

    respond_to do |format|
      if @coordinate.save
        flash[:notice] = 'Coordinate was successfully created.'
        format.html { redirect_to :back }
        format.xml  { render :xml => @coordinate, :status => :created, :location => @coordinate }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @coordinate.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /coordinates/1
  # PUT /coordinates/1.xml
 

  # DELETE /coordinates/1
  # DELETE /coordinates/1.xml
  def destroy
    @coordinate = Coordinate.find(params[:id])
    @coordinate.destroy

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
      params.require(:coordinate).permit(:territory_id, :coordinate)
    end





end
