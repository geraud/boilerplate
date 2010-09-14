Rails.application.routes.draw do |map|
  $stderr.puts Boilerplate.inspect
  $stderr.puts 'drawing routes'
  #  $stderr.puts Boilerplate.options.inspect
  #  ilerplate.disable_facebook
  resources :user_sessions, :controller => 'boilerplate/user_sessions', :only => [:create, :destroy]

end
