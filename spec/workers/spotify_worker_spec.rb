require 'rails_helper'
RSpec.describe SpotifyWorker, type: :worker do
  before(:each) do
    Album.any_instance.stub(:save_tracks)
  end
  let(:artist) { Artist.create(name: 'Built to Spill') }
  context 'album is found in api' do
    it 'saves the tracks for the album' do
      album = Album.create(
        title: 'Perfect From Now On',
        year: 1997, artist_id: artist.id
      )
      SpotifyWorker.new.perform(album.id)
      expect(album.tracks.size).to eq(8)
    end
  end
  context 'album is not found' do
    it 'creates no tracks' do
      album = Album.create(
        title: 'We Didn\'t make this album',
        year: 1997, artist_id: artist.id
      )
      SpotifyWorker.new.perform(album.id)
      expect(album.tracks.size).to eq(0)
    end
  end
end
