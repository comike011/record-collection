module AlbumHelper
  def title(artist)
    return " for #{artist.name}" if artist.present?
  end

  def delete_path(album, artist = nil)
    return artist_album_path(artist.id, album.id) if artist.present?
    album_path(album.id)
  end
end
