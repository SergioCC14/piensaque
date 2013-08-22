class User < ActiveRecord::Base
  attr_accessible :email, :rank, :nick, :password, :name, :surname,:mt_rock, :mt_pop, :mt_electronic, :mt_instrumental, :mt_jazz, :mt_hiphop, :mt_country, :avatar

  # Avatar
  has_attached_file :avatar, :styles => {
    icon:    '50x50#'   ,
    thumb:  '100x100>'  ,
    cthumb:  '100x100#' ,
    cmedium: '200x200>' ,
    medium:  '200x200#' ,
    cbig:    '300x300#' ,
  }, :default_url => "/system/users/avatars/avatar_default.png"

  validates_attachment :avatar, :content_type => { :content_type => "image/jpg" }

  has_one :playlists, :dependent => :destroy
  has_many :pnsqs, :dependent => :destroy
	before_create :assign_rank
	before_create :generate_remember_token

	# Método para asignar permisos
	# BIG_BOSS 	- Nivel alto
	# ADMIN 	  - Nivel medio
	# DEFAULT 	- Nivel bajo
	def assign_rank(options={})
		if options.blank?
			self.rank = 'DEFAULT'
    end
	end

  def admin?
    self.rank == 'ADMIN' or legendary_soldier?
  end

  def legendary_soldier?
    self.rank == 'BIG BOSS'
  end

	# Comprueba si el nick ha sido utilizado
	# Change the nick if its the case
	def used_nick(user_nick)
		if !User.find_by_nick(user_nick).blank?
			self.nick = self.nick + (rand(Time.now.sec * Time.now.min)).to_s
		end
	end

	def generate_number
		return (rand(Time.now.sec * Time.now.min)).to_s
	end	

  # Genera un Token de base 64
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  # Cifra usando SHA1 el token
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    # Genera un Token único por sesión al usuario
    def generate_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
