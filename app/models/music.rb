class Music < ActiveRecord::Base
  # has_many :music_stores, :dependent => :destroy

  attr_accessible  :title, :artist, :album, :genre, :song, :cover, :song_ogg


  has_attached_file :song
  has_attached_file :cover, :styles => {
    thumb: '100x100>' ,
    square: '200x200#' ,
    medium: '300x300>' ,
  }

  # # # # # # # # # # # # # Funciones # # # # # # # # # # # # #

  # From -> http://www.ignoredbydinosaurs.com/2013/04/converting-mp3s-ogg-files-background-sidekiq-and-ffmpeg
  # Ellos usaban ffmpeg pero esta deprecated
  # Yo uso avconv, pero el sistema es el mismo
  # La actualizacion del fichero tambien es propia.
  def mp3toOgg
    path = "#{self.song.path}"
    url = "#{self.song.url}"

    ogg_path = path.gsub(/mp3/, "ogg")
    ogg_url = url.gsub(/mp3/, "ogg")

    # Lo fuerzo a 128k
    yup = %x[avconv -i #{path} -b 128k -acodec libvorbis #{ogg_path}]

    self.ogg_song_file_size     = File.size(ogg_path)       # => Tamaño
    self.ogg_song_content_type  = 'audio/mpeg'              # => Tipo
    self.ogg_song_file_name     = File.basename(ogg_path)   # => Nombre 
    self.ogg_song_updated_at    = self.song_updated_at      # => Updated
    self.ogg_song_file_path     = ogg_path                  # => Ruta (path)
    self.ogg_song_file_url      = ogg_url                   # => URL
    self.save
    return true
  end

end
