boilerplate_path = File.expand_path('../../lib', __FILE__)
$:.unshift(boilerplate_path) if File.directory?(boilerplate_path) && !$:.include?(boilerplate_path)

require 'action_pack'
require 'active_support/dependencies/autoload'

module Boilerplate
  extend ActiveSupport::Autoload
  autoload :Authentication
  autoload :FeedbackHandling
end

require 'boilerplate/engine'
require 'boilerplate/railtie'
