Rails.application.routes.draw do |map|
   resources :sessions, :controller => 'boilerplate/sessions', :only => [:create, :delete]
 end
