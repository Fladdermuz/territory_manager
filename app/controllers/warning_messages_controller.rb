class WarningMessagesController < ApplicationController


  def hide_message

  @warning_message = WarningMessage.new(warning_message_params)
  @warning_message.save

  respond_to do |format|
    format.js
   end

  end



    private


    # Never trust parameters from the scary internet, only allow the white list through.
    def warning_message_params
      params.require(:warning_message).permit(:user_id, :msg_name,:hide)
    end


end
