class MainController < ApplicationController
   before_filter :login_required, only: [:index]
   before_action :setup, only: [:index]


  def index
    @territories = Territory.where(client_id: session[:client_id],is_checked_in: TRUE).order('checkout_date ASC').limit(8)

  end

  def help

  end



  def change_lang

    session[:locale] = params[:lang]

    I18n.locale = session[:locale]
    redirect_to :back



  end



end
