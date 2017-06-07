class ArtworksController < ApplicationController
    before_action :set_artwork, only: [:show, :update, :destroy]

    def index
        @artworks = Artwork.all
        render json: @artworks, status: :ok 
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
        render json: @artwork, status: :ok
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
        params.permit(:artist_id, :title, :description, :price, :width, :height, :status)
    end

    def set_artwork
        @artwork = Artwork.find(params[:id])
    end
end
