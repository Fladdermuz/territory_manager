class CongregationsController < ApplicationController
     before_filter :login_required,:isadminuser
     before_action :set_congregation, only: [:show, :edit, :update, :destroy]


     # GET /congregations
  # GET /congregations.xml
  def index
    @congregations = Congregation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @congregations }
    end
  end

  # GET /congregations/1
  # GET /congregations/1.xml
  def show
    @congregation = Congregation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @congregation }
    end
  end

  # GET /congregations/new
  # GET /congregations/new.xml
  def new
    @congregation = Congregation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @congregation }
    end
  end

  # GET /congregations/1/edit
  def edit
    @congregation = Congregation.find(params[:id])
  end

  # POST /congregations
  # POST /congregations.xml
  def create
    @congregation = Congregation.new(params[:congregation])

    respond_to do |format|
      if @congregation.save
        flash[:notice] = 'Congregation was successfully created.'
        format.html { redirect_to(@congregation) }
        format.xml  { render :xml => @congregation, :status => :created, :location => @congregation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @congregation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /congregations/1
  # PUT /congregations/1.xml
  def update

    respond_to do |format|
      if @congregation.update(congregation_params)
        flash[:notice] = 'Congregation was successfully updated.'
        format.html { redirect_to(@congregation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @congregation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /congregations/1
  # DELETE /congregations/1.xml
  def destroy

    @congregation.destroy

    respond_to do |format|
      format.html { redirect_to(congregations_url) }
      format.xml  { head :ok }
    end
  end

     private
  # Use callbacks to share common setup or constraints between actions.
     def set_congregation
       @congregation = Congregation.find_by(id: params[:id])
     end

  # Never trust parameters from the scary internet, only allow the white list through.
     def congregation_params
       params.require(:congregation).permit(:congname, :address, :city, :state, :country, :language, :contact_id)
     end

end
