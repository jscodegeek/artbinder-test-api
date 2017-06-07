class ImageFile < ApplicationRecord
    belong_to :artworks

    def self.save_file(upload)
        file_name = upload[:datafile].original_filename if upload[:datafile] !=''
        file = upload[:datafile].read

        file_type = file_name.split('.').last
        new_name_file = Time.now.to_i
        name_folder = new_name_file
        new_file_name_with_type = "#{new_name_file}." + file_type

        image_root = "/"
        Dir.mkdir(image_root + "#{name_folder}");

        File.open(image_root + "#{name_folder}/" + new_file_name_with_type, "wb")  do |f|  
            f.write(file) 
        end

    end 
end
