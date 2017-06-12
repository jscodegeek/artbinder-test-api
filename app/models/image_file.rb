class ImageFile < ApplicationRecord
    validates :name, :base64, presence: true

    belongs_to :artwork

    after_create :save_file
    before_create :check_dimension

    IMAGES_FOLDER = "public/images"
    MAX_ON_LARGEST_SIDE = 800
    SQUARE_SIDE = 300

    def check_dimension
        @base_64_encoded_data = self.base64

        @blob_image = Base64.decode64(@base_64_encoded_data)
        
        @image = MiniMagick::Image.read(@blob_image)
        
        min_size = [@image.width, @image.height].min
        max_size = [@image.width, @image.height].max

        raise ArgumentError, "dimension is less then should be provided" unless min_size >= APP_CONFIG[:max_smallest_side] && max_size >= APP_CONFIG[:max_biggest_side] 
    end

    def save_file
       source_file_name = self.name
       image_id = self.id
       artwork = Artwork.find(self.artwork_id)
       
       file_type = source_file_name.split('.').last || 'jpg'
       
       dir_name = "public/#{APP_CONFIG[:image_folder]}/#{artwork.id}"

       Dir.mkdir(dir_name) unless File.exists?(dir_name)

       #ORIGIN
       File.open("#{dir_name}/#{image_id}_origin.#{file_type}", 'wb') {|f| f.write(@blob_image)}

       #MAX_ON_LARGEST_SIDE
       image = @image.clone
       is_album_orientation = image.width > image.height
       image.rotate "-90" unless is_album_orientation
       image.resize APP_CONFIG[:max_on_larges_side]
       image.rotate "90" unless is_album_orientation
       image.write "#{dir_name}/#{image_id}_#{APP_CONFIG[:max_on_larges_side]}.#{file_type}"

       #SQUARE_SIDE
       image = @image.clone
       image.resize "#{APP_CONFIG[:square_side]}x#{APP_CONFIG[:square_side]}"
       image.write "#{dir_name}/#{image_id}_#{APP_CONFIG[:square_side]}x#{APP_CONFIG[:square_side]}.#{file_type}"
    end 
end

