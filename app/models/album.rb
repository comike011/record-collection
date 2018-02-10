class Album < ApplicationRecord
  default_scope { order(year: :desc) }
  belongs_to :artist
  has_many :tracks, dependent: :delete_all

  after_save :save_tracks

  delegate :name, to: :artist, prefix: true

  private

  def save_tracks
    SpotifyWorker.perform_async(id)
  end
end
