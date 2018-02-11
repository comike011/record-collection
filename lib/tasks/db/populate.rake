namespace :db do
  require 'rspotify'
  desc 'Populate the database with some sample data'
  task populate: :environment do
    # rubocop:disable LineLength
    Artist.create(name: 'The Strokes')
    Artist.create(name: 'Tribe Called Quest')
    Artist.create(name: 'The Beatles')
    Artist.create(name: 'LCD Soundsystem')
    Artist.create(name: 'Phish')
    artists = Artist.all
    artists.each do |artist|
      spotify_artist = RSpotify::Artist.search(artist.name).first
      spotify_artist.albums.each do |album|
        Album.create(artist_id: artist.id, title: album.name, year: album.release_date[0...4])
      end
    end
    # rubocop:enable LineLength
  end
end
