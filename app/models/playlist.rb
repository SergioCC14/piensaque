class Playlist < ActiveRecord::Base
  
  has_many :musics
  belongs_to :users

end
