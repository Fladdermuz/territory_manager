module ApplicationHelper

  def active_class(controller,link)

    if controller == link
      return "active"
    end

  end

  def get_address_text

   if current_user.client.is_language_based?
     @address_txt = "#{t :addresses}"
   else
     @address_txt = "#{t :do_not_calls}"
   end


    return @address_txt

  end

 def get_best_coord(obj)

  @coord = ''
  if obj.center_coordinate.blank?

    if !obj.latitude.blank? && !obj.longitude.blank?
     @coord = obj.latitude.to_s + ',' + obj.longitude.to_s
    end

  else

   @coord = obj.center_coordinate

  end

  return @coord

 end



 def get_latlong(obj)

 @coord = obj.latitude.to_s + ',' + obj.longitude.to_s

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

    def get_map_layer_id


      @map_layer = MapLayer.find_by(id: session[:map_layer_id])

      if @map_layer.nil?
        @map_layer = MapLayer.first
      end

      return @map_layer.id

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


  def show_msg(msg_name)

   @show = FALSE


   case msg_name
   when 'client_cord'
     @warn = WarningMessage.find_by(user_id: current_user.id, msg_name: 'client_cord', hide: TRUE)
     if @warn.nil?
       @show = TRUE
     end
   when 'zone_cord'
     @warn = WarningMessage.find_by(user_id: current_user.id, msg_name: 'zone_cord', hide: TRUE)
     if @warn.nil?
       @show = TRUE
     end
   when 'terr_cord'
     @warn = WarningMessage.find_by(user_id: current_user.id, msg_name: 'terr_cord', hide: TRUE)
     if @warn.nil?
       @show = TRUE
     end
   when 'coord_tip'
     @warn = WarningMessage.find_by(user_id: current_user.id, msg_name: 'coord_tip', hide: TRUE)
     if @warn.nil?
       @show = TRUE
     end
   end


   return @show

  end


end
