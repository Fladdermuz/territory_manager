class HouseholdersController < ApplicationController
  before_action :set_householder, only: [:show, :edit, :update, :destroy]
  before_filter :login_required
   
  def index

    @householders= Householder.where(congregation_id: session[:congid]).paginate(:page => params[:page], :per_page => 30).order('fname ASC,lname ASC')

    respond_to do |format|
      format.html # index.html.erb
     end
  end

  # GET /householders/1
  # GET /householders/1.xml
  def show

    if !@householder.address_id.nil?
      @address = Address.find_by(id: @householder.address_id, congregation_id: session[:congid])
    end

    respond_to do |format|
      format.html # show.html.erb
     end
  end

  # GET /householders/new
  # GET /householders/new.xml
  def new

    @householder = Householder.new
    @addressID = params[:addressID]
    if !@addressID.nil?    
    @address = Address.find_by(id: @addressID, congregation_id: session[:congid])
    end

    respond_to do |format|
      format.html # new.html.erb
     end
  end

  # GET /householders/1/edit
  def edit

  end

  # POST /householders
  # POST /householders.xml
  def create
    @householder = Householder.new(householder_params)
    @cong = Congregation.find(session[:congid])
    respond_to do |format|
      if @householder.save
        flash[:notice] = t :creation_success
        format.html { redirect_to(@householder) }
       else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /householders/1
  # PUT /householders/1.xml
  def update
    @householder = Householder.find(params[:id],:conditions => "congregation_id = '#{session[:congid]}'")

    respond_to do |format|
      if @householder.update_attributes(params[:householder])
        flash[:notice] = 'Householder was successfully updated.'
        format.html { redirect_to(@householder) }
       else
        format.html { render :action => "edit" }
       end
    end
  end

  # DELETE /householders/1
  # DELETE /householders/1.xml
  def destroy
    @householder = Householder.find(params[:id])
    @householder.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end


  def home
   
  end
  




def add_hh_to_address

  @hh_id = params[:hh_id]
  
  @address_id = params[:addressid]

  @hh = Householder.find(@hh_id,:conditions => "congregation_id = '#{session[:congid]}'")

  @hh.address_id = @address_id

  @hh.save

  redirect_to :back

end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_householder
    @householder = Householder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def householder_params
    params.require(:householder).permit(:fname, :lname,:notes, :phone, :address_id, :call_date)
  end
end

