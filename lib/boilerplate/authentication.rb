require 'rails'

module Boilerplate
  module Authentication

  protected

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      return @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      return @current_user = current_user_session && current_user_session.valid? && current_user_session.record
    end

    def login_as(user)
      logout
      UserSession.create!(user)
    end

    def logged_in?
      return current_user != nil
    end

    def logout
      UserSession.find.try(:destroy)
      remove_instance_variable(:@current_user_session) if defined?(@current_user_session)
      remove_instance_variable(:@current_user) if defined?(@current_user)
    end

    def self.included(application_controller)
      application_controller.class_eval do
        #  helper_method :current_user_session
        helper_method :current_user
        helper_method :logged_in?
        #  Authlogic::Session::Base.controller
      end
    end

  end
end
