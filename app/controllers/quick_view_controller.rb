class QuickViewController < ApplicationController
  layout "pdf"


  def auto_checkin

   if params[:site_key].to_s == ENV['site_key'].to_s
       @territories = Territory.where(is_checked_in: FALSE)

       @territories.each do |t|

        if t.check_back_in.to_date <= Date.today
         check_in_terr(t)
        end


       end

   end


  end

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


  def render_pdf_user


    @territory = Territory.find_by(id: params[:id])



    if current_user.can_manage_hh? && @territory.user_id != current_user.id
      redirect_to :root
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
