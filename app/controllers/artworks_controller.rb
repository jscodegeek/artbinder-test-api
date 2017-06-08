class ArtworksController < ApplicationController
    before_action :set_artwork, only: [:show, :update, :destroy]

    def index
        @artworks = Artwork.all
        render json: @artworks, status: :ok 
    end

    def create
        @artist = Artist.find(artwork_params[:artist_id])
        @artworks = @artist.artworks.create(artwork_params)
        render json: @artworks, status: :created
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
        params.permit(:artist_id, :title, :description, :price, :width, :height, :status, :images)
    end

    def set_artwork
        @artwork = Artwork.find(params[:id])
    end
end
