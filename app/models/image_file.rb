class ImageFile < ApplicationRecord
    belongs_to :artworks

    IMAGES_FOLDER = "images"

    def self.save_file(params)
       source_file_name = params[:name] 
       base_64_encoded_data = params[:base64] 
       
       file_type = source_file_name.split('.').last
       file_name = Time.now.to_i
       name_folder = file_name
       file_name_with_type = "#{file_name}.#{file_type}" 

       Dir.mkdir("#{IMAGES_FOLDER}/#{name_folder}");

       File.open("#{IMAGES_FOLDER}/#{name_folder}/#{file_name_with_type}", 'wb') do|f|
           f.write(Base64.decode64(base_64_encoded_data))
       end
    end 
end
