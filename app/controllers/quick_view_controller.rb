class QuickViewController < ApplicationController
  layout "pdf"

  def view_terr

    @territory = Territory.find_by(view_key: params[:key])

    if @territory.nil?
      redirect_to :root
      session[:user] = nil
    else
      session[:user] = @territory.user
    end


  end


  def render_pdf
    login_required

    @territory = Territory.find_by(id: params[:id])
    @addresses = @territory.addresses

    respond_to do |format|

    format.html do
      render pdf: "terr_#{@territory.territory_no}"   # Excluding ".pdf" extension.
    end
  end

  end


  def home

    @territories


  end
end
