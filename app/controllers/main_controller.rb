class MainController < ApplicationController
   before_filter :login_required, only: [:index]
   before_action :setup, only: [:index]


  def index
    @territories = Territory.where(client_id: current_user.client_id).order('checkout_date ASC').limit(8)
    @zones = Zone.where(client_id: current_user.client_id)

  end

  def help

   @zones = Zone.where(client_id: current_user.client_id)

   @zones_no_cords = Zone.no_cords(current_user.client_id)
   @territories_no_cords = Territory.no_cords(current_user.client_id)

   @territories = Territory.where(client_id: current_user.client_id)


  end



  def change_lang

    session[:locale] = params[:lang]

    I18n.locale = session[:locale]
    redirect_to :back



  end



end
