class QuickViewController < ApplicationController

  def view_terr

    @territory = Territory.find_by(view_key: params[:key])

    if @territory.nil?
      redirect_to :root
      session[:user] = nil
    else
      session[:user] = @territory.user
    end


  end

  def home

    @territories


  end
end
