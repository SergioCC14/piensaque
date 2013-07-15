class User < ActiveRecord::Base
  attr_accessible :email, :rank, :nick, :password

	before_save :assign_rank


	# Método para asignar permisos
	# BIG_BOSS 	- Nivel alto
	# ADMIN 		- Nivel medio
	# DEFAULT 	- Nivel bajo
	def assign_rank(options={})
		user = user.find(options[:id])
		if options.blank?
			user.update_attributes(:rank => 'default')
		elsif (options[:rank] == "BIG BOSS")
			user.update_attributes(:rank => options[:rank])
		end
			

	end

end
