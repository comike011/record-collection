class Album < ApplicationRecord
  default_scope { order(year: :desc) }
  belongs_to :artist
  has_many :tracks, dependent: :delete_all

  delegate :name, to: :artist, prefix: true
end
