class Music < ActiveRecord::Base
  belongs_to :playlists

  has_attached_file :song
  has_attached_file :ogg_song

  has_attached_file :cover, :styles => {
    icon:    '50x50#'   ,
    thumb:   '100x100>' ,
    cthumb:  '100x100#' ,
    cmedium: '200x200>' ,
    medium:  '200x200#' ,
    cbig:    '300x300#' ,
  }

  # before_save :mp3toOgg

  # # # # # # # # # # # # # Funciones # # # # # # # # # # # # #

  # From -> http://www.ignoredbydinosaurs.com/2013/04/converting-mp3s-ogg-files-background-sidekiq-and-ffmpeg
  # Ellos usaban ffmpeg pero esta deprecated
  # Yo uso avconv, pero el sistema es el mismo
  # La actualizacion del fichero tambien es propia.

  # Metodo actual, lo lanzo después manualmente
  def mp3toOgg
    path = "#{self.song.path}"
    url = "#{self.song.url}"

    ogg_path = path.gsub(/mp3/, "ogg")
    ogg_url = url.gsub(/mp3/, "ogg")

    raise ogg_path.inspect

    # Lo fuerzo a 128k
    yup = %x[avconv -i #{path} -b 128k -acodec libvorbis #{ogg_path}]

    # self.ogg_song_file_size     = File.size(ogg_path)       # => Tamaño
    # self.ogg_song_content_type  = 'audio/mpeg'              # => Tipo
    # self.ogg_song_file_name     = File.basename(ogg_path)   # => Nombre 
    # self.ogg_song_updated_at    = self.song_updated_at      # => Updated
    # self.ogg_song_file_path     = ogg_path                  # => Ruta (path)
    # self.ogg_song_file_url      = ogg_url                   # => URL
    self.save
    return true
  end

end
