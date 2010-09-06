require 'rails/generators'

module Boilerplate
  class UpdateJsGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../../../../../', __FILE__)

    def install
      directory 'app/javascripts'
    end

  end
end
