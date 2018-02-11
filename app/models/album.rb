class Album < ApplicationRecord
  default_scope { order(year: :desc) }
  belongs_to :artist
  has_many :tracks, dependent: :delete_all

  after_create :save_tracks
  after_create :save_word_frequency

  validates_uniqueness_of :title, scope: :artist_id

  delegate :name, to: :artist, prefix: true

  private

  def save_tracks
    SpotifyWorker.perform_async(id)
  end

  def save_word_frequency
    return unless artist.present?
    TitleWordFrequencyWorker.perform_async(artist.id, title)
  end
end
