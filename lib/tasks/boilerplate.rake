namespace :boilerplate do
  root = File.expand_path('../../..', __FILE__)

  desc 'aontheuanth'
  task :update do
  end

  desc 'Creates the symlinks in public for deployment'
  task :create_symlinks do
    source_path = File.join(root, 'app/javascripts')
    target_path = File.join(Rails.root, 'public/javascripts/boilerplate')
    sh "ln -nsf #{source_path} #{target_path}"
    #  $stderr.puts "root: #{Rails.root} #{root}"
  end

end
