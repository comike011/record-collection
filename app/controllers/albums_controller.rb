class AlbumsController < ApplicationController
  helper AlbumHelper
  before_action :load_album, only: %i[edit destroy update]
  def index
    if params['artist_id'].present?
      @albums = Album.where(artist_id: params['artist_id'])
      @artist = Artist.find(params['artist_id'])
    else
      @albums = Album.all
    end
  end

  def edit; end

  def update
    if @album.update_attributes(album_params)
      redirect_to action: 'index', status: 303
    else
      render 'edit'
    end
  end

  def new
    @album = Album.new(artist_id: params['artist_id'])
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to action: 'index', artist_id: params['artist_id']
    else
      render 'new'
    end
  end

  def destroy
    @album.destroy
    redirect_to action: 'index', artist_id: params['artist_id']
  end

  private

  def load_album
    @album = Album.find(params['id'])
  end

  def album_params
    params.require(:album).permit(:title, :year, :artist_id)
  end
end
