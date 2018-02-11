require 'rails_helper'
RSpec.describe TitleWordFrequencyWorker, type: :worker do
  describe '#perform' do
    it 'calls the create for the number of title words' do
      expect(TitleWordFrequency).to receive(:create).twice
      TitleWordFrequencyWorker.new.perform(1, 'A Title')
    end
  end
end
