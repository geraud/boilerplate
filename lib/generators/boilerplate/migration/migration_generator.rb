require 'rails/generators'
require 'rails/generators/active_record'

module Boilerplate
  class MigrationGenerator < ::ActiveRecord::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    argument :name, :type => :string, :default => 'add_boilerplate_tables'

    def create_migration_file
      migration_template "migration.rb", "db/migrate/#{file_name}.rb"
    end

  protected

    #  def user_table_name
    #    current_table_name = Boilerplate::User.table_name
    #    $stderr.puts current_table_name.inspect
    #    current_table_name
    #  end

  end
end
