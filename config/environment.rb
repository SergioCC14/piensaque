# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PiensaQue::Application.initialize!

# http://stackoverflow.com/questions/5286117/incompatible-character-encodings-ascii-8bit-and-utf-8
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8