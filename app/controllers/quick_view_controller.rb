class QuickViewController < ApplicationController
  layout "pdf"

  def view_terr

    @territory = Territory.find_by(view_key: params[:key])

    if @territory.nil? || @territory.view_key.nil?
      redirect_to :root
      session[:user] = nil
    else
      session[:user] = @territory.user
    end


  end


  def render_pdf

    @territory = Territory.find_by(view_key: params[:key])

    if @territory.nil? || @territory.view_key.nil?
      redirect_to :root
      session[:user] = nil
    else
      @addresses = @territory.addresses

      respond_to do |format|
        format.html do
         render pdf: "terr_#{@territory.territory_no}"   # Excluding ".pdf" extension.
        end
      end
      
    end


  end


  def home

    @territories


  end
end
