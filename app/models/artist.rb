class Artist < ApplicationRecord
  default_scope { order(:name) }
  has_many :albums, dependent: :delete_all
  has_many :tracks, through: :albums
  has_many :title_word_frequencies, dependent: :delete_all
  before_save :format_name

  private

  def format_name
    self.name = if name.downcase.start_with?('the')
                  (name.downcase.sub('the ', '') << ', The').titleize
                else
                  name.titleize
                end
  end
end
