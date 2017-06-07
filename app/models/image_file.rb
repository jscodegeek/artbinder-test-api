class ImageFile < ApplicationRecord
    belongs_to :artwork

    after_create :save_file

    IMAGES_FOLDER = "images"

    def save_file
       source_file_name = self.name
       image_id = self.id
       artwork = Artwork.find(self.artwork_id)
       base_64_encoded_data = self.base64
       
       file_type = source_file_name.split('.').last
       
       dir_name = "#{IMAGES_FOLDER}/#{artwork.id}"

       Dir.mkdir(dir_name) unless File.exists?(dir_name)

       #ORIGIN
       File.open("#{dir_name}/#{image_id}_origin.#{file_type}", 'wb') do|f|
           f.write(Base64.decode64(base_64_encoded_data))
       end
    end 
end

