module AlbumHelper
  def title(artist)
    return " for #{artist.name}" if artist.present?
  end
end
