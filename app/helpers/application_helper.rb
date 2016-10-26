module ApplicationHelper

  def active_class(controller,link)

    if controller == link
      return "active"
    end

  end


  def is_client_admin
  @is_client_admin = FALSE

   if session[:role].to_s == "client_admin"
     @is_client_admin = FALSE
   end

   return @is_client_admin
  end


  def is_admin
  @is_admin = FALSE

   if session[:role].to_s == "admin"
    @is_admin = FALSE
   end

   return @is_admin

  end


    def get_map_layer


      @map_layer = MapLayer.find_by(id: session[:map_layer_id])

      if @map_layer.nil?
        @map_layer = MapLayer.first
      end

      return @map_layer

    end



    def new_or_update(object)

      if object.new_record?
        @button_txt = "#{t :create}"
      else
        @button_txt = "#{t :update}"
      end

      return @button_txt
    end

  def current_user

   @current_user = User.find(session[:uid])
   return @current_user

  end


end
