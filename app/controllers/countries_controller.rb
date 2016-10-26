class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]
  before_action :is_admin_redirect

  def index
    @countries = Country.all
  end


  def new
    @country = Country.new
  end


  def edit
  end


  def create
    @country = Country.new(country_params)

    respond_to do |format|
      if @country.save
        format.html { redirect_to countries_path }
       else
        format.html { render :new }
       end
    end
  end



  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to countries_path }
       else
        format.html { render :edit }
       end
    end
  end



  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to countries_path }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def country_params
      params.require(:country).permit(:name, :code, :region, :flag)
    end
end
