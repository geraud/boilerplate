module Boilerplate

  class Railtie < Rails::Railtie
    config.boilerplate = ActiveSupport::OrderedOptions.new

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
