class SpotifyWorker
  include Sidekiq::Worker
  require 'rspotify'

  def perform(album_id)
    album = Album.find(album_id)
    spotify_artist = spotify_artist(album.artist_name)
    spotify_album = spotify_album(spotify_artist, album.title)
    tracks(spotify_album).each_with_index do |track, index|
      Track.create(album_id: album.id, title: track.name, number: (index + 1))
    end
  end

  def spotify_artist(artist_name)
    RSpotify::Artist.search(artist_name).first
  end

  def spotify_album(spotify_artist, album_title)
    return '' unless spotify_artist.present?
    spotify_artist.albums.find do |a|
      a.instance_variable_get('@name').include?(album_title)
    end
  end

  def tracks(spotify_album)
    return [] unless spotify_album.present?
    spotify_album.tracks
  end
end
