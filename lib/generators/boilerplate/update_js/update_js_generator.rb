require 'rails/generators'

module Boilerplate
  class UpdateJsGenerator < ::Rails::Generators::Base
    def install
      directory 'app/javascripts'
    end

    def self.source_root
      File.expand_path('../../../../../', __FILE__)
    end
  end
end
