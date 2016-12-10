class UserMailer < ApplicationMailer


  def send_user(user,pw)
    @user = user
    @email = user.email
    @locale = user.sitelang
    @loc = I18n
    @loc.locale =  @locale
    @pw = pw
    @save = @loc.translate :please_save
    @username = @loc.translate :username
    @password = @loc.translate :password
    @your = @loc.translate :your
    @subject = @loc.translate :new_user_subject
    mail(to: "#{@email}", subject: "#{@subject}")
  end


  def send_terr(user,terr)
    @user = user
    @email = user.email
    @full_name = user.full_name
    @locale = user.sitelang
    @loc = I18n
    @loc.locale =  @locale
    @url = "#{ENV['site_root'].to_s}/quick_view/view_terr?key=#{terr.view_key.to_s}"
    @pdf = "#{ENV['site_root'].to_s}/quick_view/render_pdf?key=#{terr.view_key.to_s}"
    @message1 = @loc.translate :terr_message1
    mail(to: "#{@email}", subject: "#{@subject}")
  end

end
