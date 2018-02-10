class AlbumsController < ApplicationController
  helper AlbumHelper
  def index
    if params['artist_id'].present?
      @albums = Album.where(artist_id: params['artist_id'])
      @artist = Artist.find(params['artist_id'])
    else
      @albums = Album.all
    end
  end
end
