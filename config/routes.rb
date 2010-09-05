Rails.application.routes.draw do |map|
   resources :user_sessions, :controller => 'boilerplate/user_sessions', :only => [:create, :destroy]

 end
