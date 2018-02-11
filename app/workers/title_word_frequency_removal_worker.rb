class TitleWordFrequencyRemovalWorker
  include Sidekiq::Worker

  def perform(artist_id, title)
    title.split.each do |word|
      TitleWordFrequency.remove(artist_id, word)
    end
  end
end
