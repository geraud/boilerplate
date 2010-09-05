class Boilerplate::UserSessionsController < ::ApplicationController

  def create
    user_session = UserSession.create(params[:user_session])
    unless user_session.valid?
      logout
      return add_error('user_session', user_session)
      # remember_login if params[:session][:remember_login]
    end
  end

  def destroy
    logout if logged_in?
    forget_login
  end

end
