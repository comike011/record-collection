class Artist < ApplicationRecord
  default_scope { order(:name) }
  has_many :albums, dependent: :delete_all
  has_many :tracks, through: :albums
  has_many :title_word_frequencies, dependent: :delete_all
  before_save :format_name

  validates_uniqueness_of :name

  def record_year_min
    return '' unless albums.present?
    albums.last.year
  end

  def record_year_max
    return '' unless albums.present?
    albums.first.year
  end

  # rubocop:disable MethodLength
  def self.to_csv(artists)
    values = ['Name', 'Num Records', 'Year Range', 'Common Word']
    output = CSV.generate(headers: true) do |csv|
      csv << values
      artists.each do |artist|
        next unless artist.albums.present?
        csv << [
          artist.name,
          artist.albums.size,
          "#{artist.record_year_min} - #{artist.record_year_max}",
          artist.title_word_frequencies.first.word
        ]
      end
    end
    output
  end
  # rubocop:enable MethodLength

  private

  def format_name
    self.name = if name.to_s.downcase.start_with?('the')
                  (name.downcase.sub('the ', '') << ', The').to_s.titleize
                else
                  name.to_s.titleize
                end
  end
end
