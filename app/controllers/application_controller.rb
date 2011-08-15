class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
def current_game
Game.find(session[:game_id])
rescue ActiveRecord::RecordNotFound
game = Game.create
session[:game_id] = game.id
game
end
end
