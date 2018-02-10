class Artist < ApplicationRecord
  default_scope { order(:name) }
  has_many :albums, dependent: :delete_all
  has_many :tracks, through: :albums
end
