class TerritoryHistoriesController < ApplicationController
    before_filter :login_required
    before_filter :isadminuser
    before_action :set_territory_history, only: [:show, :edit, :update, :destroy]

  def index

     @territory_histories = TerritoryHistory.where(congregation_id: session[:congid]).joins(:territory).paginate(:page => params[:page], :per_page => 30).order('territories.territory_no+0,territory_histories.check_out_date')
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
    @territory_history = TerritoryHistory.find_by(id: params[:id],congregation_id: session[:congid])
    @territory_history.destroy

    respond_to do |format|
      format.html { redirect_to(territory_histories_url) }
     end
  end




  def report

    @territories = Territory.where(congregation_id: session[:congid]).includes(:territory_histories).paginate(:page => params[:page], :per_page => 30).order('territories.territory_no+0 ASC')

  end


    private
     def set_territory_history
      @territory_history = TerritoryHistory.find_by(id: params[:id],congregation_id: session[:congid])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def territory_history_params
      params.require(:territory_history).permit(:check_out_date, :check_in_date, :checked_out_by, :territory_id, :congregation_id)
    end



end
