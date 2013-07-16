class User < ActiveRecord::Base
  attr_accessible :email, :rank, :nick, :password

	before_save :assign_rank

	# Método para asignar permisos
	# BIG_BOSS 	- Nivel alto
	# ADMIN 	- Nivel medio
	# DEFAULT 	- Nivel bajo
	def assign_rank(options={})
		if options.blank?
			self.rank = 'DEFAULT'
		elsif (options[:rank] == "BIG BOSS")
			self.rank = options[:rank]
		end
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

end
