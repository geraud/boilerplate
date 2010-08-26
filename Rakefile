require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'boilerplate'
    gem.summary = %Q{Basic code for a rails app}
    gem.description = %Q{Basic code for a rails app}
    gem.email = 'geraud@gmail.com'
    gem.homepage = 'http://github.com/geraud/boilerplate'
    gem.authors = ['Geraud Boyer']
    gem.add_development_dependency 'rspec', ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.files += Dir['{lib}/**/*', '{app}/**/*', '{config}/**/*']
    gem.add_dependency 'authlogic'
    gem.add_dependency 'haml'
    #  gem.add_dependency 'authlogic_openid'

  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :build

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "boilerplate #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
