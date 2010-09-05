require 'haml'
require 'sass'
raise 'Boilerplate is for rails 3' unless defined?(Rails) && Rails::VERSION::MAJOR == 3

require 'boilerplate/engine'
require 'boilerplate/authentication'
require 'boilerplate/feedback_handling'
