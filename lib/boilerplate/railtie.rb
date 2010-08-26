module Boilerplate

  class Railtie < Rails::Railtie

    rake_task do
      $stderr.puts 'rake task'
    end

  end

end
