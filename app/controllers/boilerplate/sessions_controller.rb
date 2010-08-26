class Boilerplate::SessionsController < ::ApplicationController
  unloadable

  def index
    render :text => 'yo!'
  end

end
