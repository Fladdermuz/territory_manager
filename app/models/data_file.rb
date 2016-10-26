class DataFile < ActiveRecord::Base

  def self.save(upload,client_id)
    name =  upload['datafile'].original_filename
    directory = "public/images/#{client_id}"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end




  
  def sanitize_filename(file_name)
    # get only the filename, not the whole path (from IE)
    just_filename = File.basename(file_name)
    # replace all none alphanumeric, underscore or perioids with underscore
    just_filename.gsub(/[^\w\.\_]/,'_')
  end


end
