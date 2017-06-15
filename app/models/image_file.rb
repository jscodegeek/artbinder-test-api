class ImageFile < ApplicationRecord
    validates :name, :base64, presence: true

    belongs_to :artwork

    after_create :process_image
    before_create :prepare_image

    @@image_folder = APP_CONFIG[:image_folder]
    @@max_on_larges_side = APP_CONFIG[:max_on_larges_side]
    @@square_side = APP_CONFIG[:square_side]
    @@max_smallest_side = APP_CONFIG[:max_smallest_side]
    @@max_biggest_side = APP_CONFIG[:max_biggest_side]

    def prepare_image
        @image = MiniMagick::Image.read(Base64.decode64(self.base64))
        
        min_size = [@image.width, @image.height].min
        max_size = [@image.width, @image.height].max

        raise ArgumentError, "dimension is less then should be provided" unless min_size >= @@max_smallest_side && max_size >= @@max_biggest_side 
    end

    def process_image
       create_dir

       create_origin

       create_large @@max_on_larges_side

       create_thumbnail @@square_side
    end

    def create_dir
        Dir.mkdir(dir_name) unless File.exists?(dir_name)
        dir_name
    end

    def self.find_file_paths_by_aw_id (aw_id)
        images = self.where({ artwork_id: aw_id })
        files_paths = {}
        images.each do |img|
            files_paths[img.name] = {}
            img.paths.each do |p|
                files_paths[img.name][p[0]] = p[1] if File.exists?(p[1])
            end
        end
        files_paths
    end

    def paths
        image_id = self.id
        source_file_name = self.name
        file_type = source_file_name.split('.').last || 'jpg'

        @original_path = "#{dir_name}/#{image_id}_origin.#{file_type}"
        @large_path = "#{dir_name}/#{image_id}_large.#{file_type}"
        @thumb_path = "#{dir_name}/#{image_id}_thumb.#{file_type}"
        { :original_path => @original_path, :large_path => @large_path, :thumb_path => @thumb_path }
    end

    private

    def landscape?
        @image.width > @image.height
    end

    def create_large (val)
        image = @image.clone
        puts landscape?
        
        if landscape?
            image.rotate "-90"
            image.resize val
            image.rotate "90"
        else
            image.resize val
        end
      
        image.write paths[:large_path]
    end

    def create_thumbnail (val)
        image = @image.clone
        image.resize "#{val}x#{val}"
        image.write paths[:thumb_path]
    end

    def create_origin
        @image.write paths[:original_path]
    end

    def dir_name
        artwork_id = Artwork.find(self.artwork_id).id
        dir_name = "public/#{@@image_folder}/#{artwork_id}"
    end 
end

