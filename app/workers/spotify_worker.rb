class SpotifyWorker
  include Sidekiq::Worker
  require 'rspotify'

  sidekiq_options retry: 5

  def perform(album_id)
    album = Album.find(album_id)
    spotify_artist = spotify_artist(album.artist_name)
    spotify_album = spotify_album(spotify_artist, album.title)
    spotify_artwork(album, spotify_album)
    tracks(spotify_album).each_with_index do |track, index|
      Track.create(album_id: album.id, title: track.name, number: (index + 1))
    end
  end

  def spotify_artwork(album, sa)
    return unless sa.present?
    album.image_url = sa.instance_variable_get('@images').first['url']
    album.save
  end

  def spotify_artist(artist_name)
    RSpotify::Artist.search(artist_name).first
  end

  def spotify_album(spotify_artist, album_title)
    return '' unless spotify_artist.present?
    spotify_artist.albums.find do |a|
      a.instance_variable_get('@name').downcase.include?(album_title.downcase)
    end
  end

  def tracks(spotify_album)
    return [] unless spotify_album.present?
    spotify_album.tracks
  end
end
