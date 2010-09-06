class Boilerplate::FacebookSessionsController < ::ApplicationController

    def create
      user = find_or_create_facebook_user
      login_as user
    end

    def destroy
      logout if logged_in?
    end
  end

end
