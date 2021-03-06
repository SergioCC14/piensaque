class User < ActiveRecord::Base

  require 'digest/sha1'

  # Avatar
  has_attached_file :avatar, :styles => {
    icon:    '50x50#'   ,
    thumb:   '100x100>' ,
    cthumb:  '100x100#' ,
    cmedium: '200x200>' ,
    medium:  '200x200#' ,
    cbig:    '300x300#' ,
  }, :default_url => "/system/users/avatars/avatar_default.png"

  validates_attachment  :avatar,
                        :content_type => { 
                                          :content_type =>
                                                  ['image/jpeg',
                                                  'image/pjpeg',                   
                                                  'image/jpg',
                                                  'image/png',
                                                  'image/tif',
                                                  'image/gif'],
                                                   :message => "has to be a image"
                                          },
                        :size => { :in => 0..5.megabytes }

  has_many :pnsqs, :dependent => :destroy
  has_many :relations, :dependent => :destroy

	before_create :assign_rank
  after_create :generate_password 
  before_save :clean_nick
  after_create :check_request_invitation
  after_create :notify_admins

  # Color para TASTE
  DEFAULT_COLOR="#FFFFFF"
  ROCK_COLOR="#EE1D1D"
  POP_COLOR="#83B32B"
  ELECTRONIC_COLOR="#943805"
  INSTRUMENTAL_COLOR="#FF9B00"
  JAZZ_COLOR="#3666AE"
  COUNTRY_COLOR="#7F77CF"
  HIPHOP_COLOR="#7F327F"
  CLASSICAL_COLOR="#4EB6FF"
  DANCE_COLOR="#FF90FF"
  HEAVY_COLOR="#6D6D6D"
  REGGAE_COLOR="#00923F"
  FUNK_COLOR="#ED5F21"


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

  # Función que busca usuarios a partir de un texto
  # Puede recibir una frase con nick, nombre o apellido
  def self.search_users(field)
    return_users = []
    find = false

    # Field original pero sin dobles espacios
    clean_field = field

    # Field convertido en un array por palabra
    params = field.split(" ")[0..2].uniq

    for p in params
      if !(users = User.where('LOWER(nick) = ?', p.downcase)).blank?
        users.each{|u| return_users << u}
      end

      if ((!find) and !(users = User.where('LOWER(name) = ?', p.downcase)).blank?)
        users.each{|u| return_users << u}
      end

      if ((!find) and !(users = User.where('LOWER(surname) = ?', p.downcase)).blank?)
        users.each{|u| return_users << u}
      end
    end

    # Esto lo hago por los nombres compuestos   
    if !(users = User.where('LOWER(nick) = ?', clean_field.downcase)).blank?
      users.each{|u| return_users << u}
    end

    if (!(users = User.where('LOWER(name) = ?', clean_field.downcase)).blank?)
      users.each{|u| return_users << u}
    end

    if (!(users = User.where('LOWER(surname) = ?', clean_field.downcase)).blank?)
      users.each{|u| return_users << u}
    end

    return return_users.uniq.compact
    
  end

  # Quito espacios, elimino simbolos raros
  def self.clean_nick(nick)
    
    return nick.force_encoding('utf-8').gsub(/[-‐‒–—―⁃−­]/, '-').gsub('#', 'sharp').gsub('+', 'plus').gsub('&', 'and').unaccent.to_ascii({'ñ' => 'ñ', 'Ñ' => 'Ñ'}).downcase.gsub(/[^a-zñ0-9 ]/, ' ').strip.gsub(/[ ]+/, '-')
  end

  def clean_nick
    self.nick = User.clean_nick(self.nick)
  end

  # Comprueba si el usuario actual sigue al usuario con ID: User_id
  def following?(user_id)
    return ((Relation.where(:user_id => self.id, :user_relation_id => user_id).count > 0) ? true : false)
  end

  # Devuelve todos los PnsQ privados (Recibidos)
  def pnsq_privates_received
    return Pnsq.privates.where(:to_user_id => self.id).order('id DESC')
  end

  # Devuelve todos los PnsQ privados
  def privates_all
    return Pnsq.privates.where('to_user_id = ? OR user_id = ? ',self.id ,self.id).order('id DESC')
  end

  # Si viene de una invitación: la marcamos como hecha la invitación
  def check_request_invitation
    if (ri = RequestInvitation.find_by(email: self.email))
      ri.update_attributes(:checked => true)
    end
  end

  # Notifica cuando se crea un usuario
  def notify_admins
    if (Rails.env == "production")
      ApplicationMailer.new_user(self).deliver
    end
  end

  # Devuelve un array con los gustos musicales
  def getTastes
    tastes = []
    
    self.mt_rock          ? tastes << 'rock' : nil
    self.mt_pop           ? tastes << 'pop' : nil
    self.mt_electronic    ? tastes << 'electronic' : nil
    self.mt_instrumental  ? tastes << 'instrumental' : nil
    self.mt_jazz          ? tastes << 'jazz' : nil
    self.mt_country       ? tastes << 'country' : nil
    self.mt_hiphop        ? tastes << 'hiphop' : nil
    self.mt_classical     ? tastes << 'classical' : nil
    self.mt_dance         ? tastes << 'dance' : nil
    self.mt_heavy         ? tastes << 'heavy' : nil
    self.mt_reggae        ? tastes << 'raggae' : nil
    self.mt_funk          ? tastes << 'funk' : nil

    return tastes
  end

	def generate_number
		return (rand(Time.now.sec * Time.now.min)).to_s
	end	

  # Genera un Token de base 64
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  # Cifra usando SHA2 el token
  def User.encrypt(token)
    Digest::SHA2.hexdigest(token.to_s)
  end

  # Recibe una contraseña y comprueba si es esa contraseña
  def check_password(password_to_check)
    return (self.password == User.encrypt("--#{password_to_check}--#{self.created_at}--#{self.password_salt}"))
  end

    # Genera un Token único por sesión al usuario
    def generate_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    # Creacion de contraseña: Genera una contraseña para el usuario
    #   - Prepara una salt para el usuario
    #   - Encriptación de contraseña (contraseña, created_at, salt)
    def generate_password
      self.password_salt = User.encrypt("--#{Time.now.utc}--#{ENV['SALT']}")
      self.password = User.encrypt("--#{self.password}--#{self.created_at}--#{self.password_salt}")
      self.save
    end

  private


end
