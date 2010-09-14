require 'rails'

module BoilerPlate
  class Engine < ::Rails::Engine

    def test=(value)
      $stderr.puts 'setting test to ' + value.to_s
    end

    config.boilerplate = ActiveSupport::OrderedOptions.new

    #  config.boilerplate.singleton_class.tap do |d|
    #  end

    initializer 'boilerplate.logger' do
      ActiveSupport.on_load(:boilerplate) { $stderr.puts 'should do something smart!'} # self.logger ||= Rails.logger }
    end

    initializer 'boilerplate.initialize_framework_caches' do
      ActiveSupport.on_load(:boilerplate) { $stderr.puts 'nhtaoeunthaoenth' } # {self.cache_store ||= RAILS_CACHE }
    end

    initializer "static assets" do |app|
      $stderr.puts "static assets #{root}"
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    initializer 'boilerplate.set_configs' do |app|
      #  paths   = app.config.paths
      options = app.config.boilerplate
      # Set some sensible defaults
      options.disable_facebook ||= false

      $stderr.puts "Disable Facebook: #{options.disable_facebook}"

      ActiveSupport.on_load(:action_controller) do
        include Boilerplate::Authentication
        include Boilerplate::FeedbackHandling
        include Boilerplate::Facebook # unless options.disable_facebook
      end

    end

  end
end
