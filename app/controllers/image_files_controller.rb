class ImageFilesController < ApplicationController
    def upload
        @image = ImageFile.save_file(params)
    end
end
