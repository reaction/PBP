class UserController < ApplicationController
  def gamelist
    @games = Game.all
    #@users = User.all
  end

end
