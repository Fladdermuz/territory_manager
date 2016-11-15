class HouseholdersController < ApplicationController
  before_action :set_householder, only: [:show, :edit, :update, :destroy]
  before_filter :login_required
  before_action :setup

  def index

    @householders= Householder.where(client_id: session[:client_id]).paginate(:page => params[:page], :per_page => 30).order('fname ASC,lname ASC')

    respond_to do |format|
      format.html # index.html.erb
     end
  end


  def show

    if !@householder.address_id.nil?
      @address = Address.find_by(id: @householder.address_id, client_id: session[:client_id])
    end

    respond_to do |format|
      format.html # show.html.erb
     end
  end




  def create

    @hsource = params[:hsource]

    @householder = Householder.new(householder_params)
    @client = Client.find(session[:client_id])
    respond_to do |format|
      if @householder.save

        flash[:notice] = t :creation_success

        case @hsource
        when 'index_terr'
         format.html { redirect_to controller: 'addresses', action: 'index_terr', territory_id: @householder.address.territory_id }
       when 'addy'
         format.html { redirect_to @householder.address }
        end


       else
        format.html { render :action => "new" }
      end
    end
  end



  def update

    respond_to do |format|


      if @householder.update(householder_params)

        @hsource = params[:hsource]

        case @hsource
        when 'index_terr'
         format.html { redirect_to controller: 'addresses', action: 'index_terr', territory_id: @householder.address.territory_id }
        when 'addy'
         format.html { redirect_to @householder.address }
        end


       else
        format.html { render :action => "edit" }
       end
    end
  end

  # DELETE /householders/1
  # DELETE /householders/1.xml
  def destroy
    @householder.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
    end
  end


  def home

  end





def add_hh_to_address

  @hh_id = params[:hh_id]

  @address_id = params[:addressid]

  @hh = Householder.find(@hh_id,:conditions => "client_id = '#{session[:client_id]}'")

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
    params.require(:householder).permit(:client_id, :fname, :lname,:notes, :phone, :address_id, :call_date)
  end
end
