namespace :db do
  desc 'Populate the database with some sample data'
  task populate: :environment do
    # rubocop:disable LineLength
    artist = Artist.create(name: 'Tribe Called Quest')
    album = Album.create(title: 'We Got It From Here...Thank You 4 Your Service', year: 2017, artist_id: artist.id)
    10.times do |i|
      Track.create(title: "Track #{i}", album_id: album.id)
    end
    album = Album.create(title: 'Beats, Rhymes & Life', year: 1996, artist_id: artist.id)
    10.times do |i|
      Track.create(title: "Track #{i}", album_id: album.id)
    end
    album = Album.create(title: 'Midnight Marauders', year: 1993, artist_id: artist.id)
    10.times do |i|
      Track.create(title: "Track #{i}", album_id: album.id)
    end
    album = Album.create(title: 'The Low End Theory', year: 1991, artist_id: artist.id)
    10.times do |i|
      Track.create(title: "Track #{i}", album_id: album.id)
    end
    album = Album.create(title: 'People\'s Instinctive Travels and the Paths of Rhythm', year: 1991, artist_id: artist.id)
    10.times do |i|
      Track.create(title: "Track #{i}", album_id: album.id)
    end
    # rubocop:enable LineLength
  end
end
