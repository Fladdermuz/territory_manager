class UserMailer < ApplicationMailer


  def send_user(user,pw)
    @user = user
    @email = user.email
    @locale = user.sitelang
    @loc = I18n
    @loc.locale =  @locale
    @pw =pw
    @save = @loc.translate :please_save
    @username = @loc.translate :username
    @password = @loc.translate :password
    @your = @loc.translate :your
    mail to: "#{@email}"
  end
end
