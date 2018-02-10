class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to action: 'index', status: 303
    else
      render 'new'
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    redirect_to action: 'index', status: 303
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end
