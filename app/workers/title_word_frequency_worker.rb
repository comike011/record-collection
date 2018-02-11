class TitleWordFrequencyWorker
  include Sidekiq::Worker

  def perform(artist_id, title)
    title.split.each do |word|
      TitleWordFrequency.create(artist_id: artist_id, word: word)
    end
  end
end
