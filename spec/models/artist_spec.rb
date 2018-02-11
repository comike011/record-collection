require 'rails_helper'
# rubocop:disable BlockLength
RSpec.describe Artist, type: :model do
  it { should have_many(:albums) }
  it { should have_many(:tracks) }
  it { should have_many(:title_word_frequencies) }
  it { should validate_uniqueness_of(:name) }
  describe '#record_year_range_min' do
    it 'returns the earliest year of artist records' do
      artist = Artist.create(name: 'Pavement')
      5.times do |i|
        Album.create(
          artist_id: artist.id,
          year: (10..20).to_a.sample.years.ago.year,
          title: "Album #{i}"
        )
        expect(artist.record_year_range_min).to eq(Album.minimum(:year))
      end
    end
  end
  describe '#record_year_range_max' do
    it 'returns the most recent year of artist records' do
      artist = Artist.create(name: 'Pavement')
      5.times do |i|
        Album.create(
          artist_id: artist.id,
          year: (10..20).to_a.sample.years.ago.year,
          title: "Album #{i}"
        )
        expect(artist.record_year_range_max).to eq(Album.maximum(:year))
      end
    end
  end
  describe '#format_name' do
    it 'name starts with \'the\' it is moved to the end' do
      Artist.create(name: 'The Unicorns')
      expect(Artist.first.name).to eq('Unicorns, The')
    end
  end
  # rubocop:enable BlockLength
end
