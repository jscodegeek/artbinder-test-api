class ArtistsController < ApplicationController
    before_action :set_artist, only: [:show, :update, :destroy]

    def index
        @artists = Artist.all
        render json: @artists, status: :ok 
    end

    def create
        @artist = Artist.create!(artist_params)
        render json: @artist, status: :created
    end

    def show
        render json: @artist, status: :ok
    end

    def update
        @artist.update(artist_params)
        head :no_content
    end

    def destroy
        @artist.destroy
        head :no_content
    end

    private
    
    def artist_params
        params.permit(:first_name, :last_name, :description, :email)
    end

    def set_artist
        @artist = Artist.find(params[:id])
    end
end
