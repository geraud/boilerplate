boilerplate_path = File.expand_path('../../lib', __FILE__)
$:.unshift(boilerplate_path) if File.directory?(boilerplate_path) && !$:.include?(boilerplate_path)

require 'active_support'
require 'active_support/dependencies/autoload'

module Boilerplate
  extend ActiveSupport::Autoload
  mattr_accessor :config

  autoload :Authentication
  autoload :FeedbackHandling
  autoload :Facebook

end

require 'boilerplate/engine'
