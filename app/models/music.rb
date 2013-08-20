class Music < ActiveRecord::Base
  # has_many :music_stores, :dependent => :destroy

  attr_accessible  :title, :artist, :album, :genre, :song, :cover

  has_attached_file :song

  has_attached_file :cover, :styles => {
    thumb: '100x100>' ,
    square: '200x200#' ,
    medium: '300x300>' ,
  }

  # From -> http://www.ignoredbydinosaurs.com/2013/04/converting-mp3s-ogg-files-background-sidekiq-and-ffmpeg
  def mp3toOgg
    path = "#{self.song.path}"
    # path = "#{self.song.url}"
    ogg = path.gsub(/mp3/, "ogg")
    yup = %x[ffmpeg -i #{path} -acodec libvorbis #{ogg}]
  end

end
