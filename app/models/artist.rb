class Artist < ApplicationRecord
  default_scope { order(:name) }
  has_many :albums, dependent: :delete_all
  has_many :tracks, through: :albums
  has_many :title_word_frequencies, dependent: :delete_all
  before_save :format_name

  validates_uniqueness_of :name

  def record_year_range_min
    albums.last.year
  end

  def record_year_range_max
    albums.first.year
  end

  private

  def format_name
    self.name = if name.to_s.downcase.start_with?('the')
                  (name.downcase.sub('the ', '') << ', The').titleize
                else
                  name.to_s.titleize
                end
  end
end
