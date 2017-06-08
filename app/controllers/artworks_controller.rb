class ArtworksController < ApplicationController
    before_action :set_artwork, only: [:show, :update, :destroy]

    IMAGES_FOLDER = "images"

    def index
        @artworks = Artwork.all
        app_url = request.base_url
        
        response = @artworks.map do |aw|
            aw_id = aw.id
            aw = aw.as_json
            aw[:images] = []
                
            dir_name = "public/#{IMAGES_FOLDER}/#{aw_id}"
            if File.exists?(dir_name)
                files = Dir.entries(dir_name).select {|f| !File.directory? f}
                files.each do |name|
                    aw[:images] << "#{app_url}/#{IMAGES_FOLDER}/#{aw_id}/#{name}"
                end
            end            
            aw
        end
        render json: response, status: :ok 
    end

    def create
        @artist = Artist.find(artwork_params[:artist_id])
        @artwork = @artist.artworks.create(artwork_params)
        images = params[:images]
        images.each do |image|
            @artwork.image_files.create({:name => image[:name], :base64 => image[:base64]})
        end

        render json: @artwork, status: :created
    end

    def show
        app_url = request.base_url
        
        aw_id = @artwork.id
        response = @artwork.as_json
        response[:images] = []
        dir_name = "public/#{IMAGES_FOLDER}/#{aw_id}"
        if File.exists?(dir_name)
            files = Dir.entries(dir_name).select {|f| !File.directory? f}
            files.each do |name|
                response[:images] << "#{app_url}/#{IMAGES_FOLDER}/#{aw_id}/#{name}"
            end
        end 

        render json: response, status: :ok
    end

    def update
        @artist = Artist.find(artwork_params[:artist_id])
        @artist.artworks.update(artwork_params)
        head :no_content
    end

    def destroy
        @artwork.destroy
        head :no_content
    end

    private
    
    def artwork_params
        params.permit(:artist_id, :title, :description, :price, :width, :height, :is_published)
    end

    def set_artwork
        @artwork = Artwork.find(params[:id])
    end
end
