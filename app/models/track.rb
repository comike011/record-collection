class Track < ApplicationRecord
  default_scope { order(:number) }
  belongs_to :album
end
