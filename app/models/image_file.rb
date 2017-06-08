class ImageFile < ApplicationRecord
    validates :name, :base64, presence: true

    belongs_to :artwork

    after_create :save_file
    before_create :check_dimension

    IMAGES_FOLDER = "public/images"
    MAX_ON_LARGEST_SIDE = 800
    SQUARE_SIDE = 300

    def check_dimension
        base_64_encoded_data = self.base64
        image = MiniMagick::Image.read(Base64.decode64(base_64_encoded_data))
        min = [image.width, image.height].min
        max = [image.width, image.height].max
        
        raise ArgumentError, "dimension is less then should be provided" unless min >= APP_CONFIG[:max_smallest_side] && max >= APP_CONFIG[:max_biggest_side] 
    end

    def save_file
       source_file_name = self.name
       image_id = self.id
       artwork = Artwork.find(self.artwork_id)
       base_64_encoded_data = self.base64
       
       file_type = source_file_name.split('.').last
       
       dir_name = "public/#{APP_CONFIG[:image_folder]}/#{artwork.id}"

       Dir.mkdir(dir_name) unless File.exists?(dir_name)

       #ORIGIN
       File.open("#{dir_name}/#{image_id}_origin.#{file_type}", 'wb') do|f|
           f.write(Base64.decode64(base_64_encoded_data))
       end

       #MAX_ON_LARGEST_SIDE
       image = MiniMagick::Image.open("#{dir_name}/#{image_id}_origin.#{file_type}")
       is_album_orientation = image.width > image.height
       image.rotate "-90" unless is_album_orientation
       image.resize APP_CONFIG[:max_on_larges_side]
       image.rotate "90" unless is_album_orientation
       image.format file_type
       image.write "#{dir_name}/#{image_id}_#{APP_CONFIG[:max_on_larges_side]}.#{file_type}"

       #SQUARE_SIDE
       image = MiniMagick::Image.open("#{dir_name}/#{image_id}_origin.#{file_type}")
       image.resize "#{APP_CONFIG[:square_side]}x#{APP_CONFIG[:square_side]}"
       image.format file_type
       image.write "#{dir_name}/#{image_id}_#{APP_CONFIG[:square_side]}x#{APP_CONFIG[:square_side]}.#{file_type}"
    end 
end

