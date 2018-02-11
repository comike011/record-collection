require 'rails_helper'

RSpec.describe TitleWordFrequency, type: :model do
  # rubocop:disable LineLength
  it { should belong_to(:artist) }
  describe '#record_title_word_frequency' do
    it 'should record non stop words' do
      artist = Artist.create(name: 'LCD Soundsystem')
      'This ain\'t about a title to record aboud home and love and trucks'.split.each do |word|
        TitleWordFrequency.record_title_word_frequency(artist.id, word)
      end
      expect(TitleWordFrequency.where(artist_id: artist.id).size).to eq(6)
    end
    it 'should increment and not create a new record for repeats' do
      artist = Artist.create(name: 'LCD Soundsystem')
      'jump into the fire jump into the fire jump into the fire'.split.each do |word|
        TitleWordFrequency.record_title_word_frequency(artist.id, word)
      end
      expect(TitleWordFrequency.where(artist_id: artist.id, word: 'fire').first.appearances).to eq(3)
    end
  end
  # rubocop:enable LineLength
end
