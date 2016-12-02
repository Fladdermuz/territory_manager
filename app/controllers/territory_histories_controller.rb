class TerritoryHistoriesController < ApplicationController
    before_action :login_required
    before_action :isadminuser
    before_action :set_territory_history, only: [:show, :edit, :update, :destroy]

  def index

     @territory_histories = TerritoryHistory.where(client_id: session[:client_id]).joins(:territory).paginate(:page => params[:page], :per_page => 30).order('territories.territory_no+0,territory_histories.check_out_date')
  end


  def show


  end


  def new
    @territory_history = TerritoryHistory.new
  end



  def edit

  end


  def create
    @territory_history = TerritoryHistory.new(territory_history_params)

    respond_to do |format|
      if @territory_history.save
        flash[:notice] = 'TerritoryHistory was successfully created.'
        format.html { redirect_to(@territory_history) }
       else
        format.html { render :action => "new" }
       end
    end
  end


  def update

    respond_to do |format|
      if @territory_history.update(territory_history_params)
        flash[:notice] = 'TerritoryHistory was successfully updated.'
        format.html { redirect_to(@territory_history) }
       else
        format.html { render :action => "edit" }
       end
    end
  end


  def destroy
    @territory_history = TerritoryHistory.find_by(id: params[:id],client_id: session[:client_id])
    @territory_history.destroy

    respond_to do |format|
      format.html { redirect_to(territory_histories_url) }
     end
  end




  def report

    @territories = Territory.where(client_id: session[:client_id]).includes(:territory_histories).paginate(:page => params[:page], :per_page => 30).order('territories.territory_no+0 ASC')

  end


    private
     def set_territory_history
      @territory_history = TerritoryHistory.find_by(id: params[:id],client_id: session[:client_id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def territory_history_params
      params.require(:territory_history).permit(:check_out_date, :check_in_date, :user_id, :territory_id, :client_id)
    end



end
