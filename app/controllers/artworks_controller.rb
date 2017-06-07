class ArtworksController < ApplicationController
    def index
        @artworks = Artwork.all
        render json: @artworks, status: :ok 
    end

    def create
        @artist = Artist.find(artwork_params[:artist_id])
        @artworks = @artist.artworks.create(artwork_params)
        render json: @artworks, status: :created
    end

    private
    
    def artwork_params
        params.permit(:artist_id, :title, :description, :price, :width, :height, :status, :images)
    end

    def set_artist
        @artworks = Artwork.find(params[:id])
    end
end
