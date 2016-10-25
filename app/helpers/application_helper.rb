module ApplicationHelper

  def active_class(controller,link)

    if controller == link
      return "active"
    end

  end



end
