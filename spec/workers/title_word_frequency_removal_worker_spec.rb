require 'rails_helper'
RSpec.describe TitleWordFrequencyRemovalWorker, type: :worker do
  describe '#perform' do
    it 'calls the remove method for the number of title words' do
      TitleWordFrequencyWorker.new.perform(1, 'A Title Title')
      expect(TitleWordFrequency).to receive(:remove).twice
      TitleWordFrequencyRemovalWorker.new.perform(1, 'Title Title')
    end
  end
end
