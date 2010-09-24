namespace :boilerplate do
  root = File.expand_path('../../..', __FILE__)

  desc 'aontheuanth'
  task :update do
  end

  desc 'Creates the symlinks in public for deployment'
  task :create_symlinks do
    source_path = File.join(root, 'app/javascripts')
    target_path = File.join(Rails.root, 'public/javascripts')
    Dir["#{source_path}/*"].each do |fs_item|
      fs_item = fs_item.sub("#{source_path}", '')
      sh "ln -nsf #{source_path}#{fs_item} #{target_path}#{fs_item}"
    end
  end

end
