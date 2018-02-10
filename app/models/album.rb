class Album < ApplicationRecord
  default_scope { order(:title) }
  belongs_to :artist
  has_many :tracks, dependent: :delete_all
  before_save :format_name
end
