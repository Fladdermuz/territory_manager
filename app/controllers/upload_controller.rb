class UploadController < ApplicationController

  def index
     render :file => '/upload/uploadfile.rhtml'
  end


  def uploadFile
    @congid = session[:congid]
    post = DataFile.save(params[:upload],@congid)
    redirect_to :back
  end


 def cleanup
   @cid = params[:cid]
   @filename = params[:filename]
   File.delete("/public/images/#{@cid}/#{@filename}")
   redirect_to :back
 end
  






end
