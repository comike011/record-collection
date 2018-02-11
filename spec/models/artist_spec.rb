require 'rails_helper'

RSpec.describe Artist, type: :model do
  it { should have_many(:albums) }
  it { should have_many(:tracks) }
  it { should have_many(:title_word_frequencies) }

  describe '#format_name' do
    it 'name starts with \'the\' it is moved to the end' do
      Artist.create(name: 'The Unicorns')
      expect(Artist.first.name).to eq('Unicorns, The')
    end
  end
end
