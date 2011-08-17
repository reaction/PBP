class Game < ActiveRecord::Base
  has_many :posts
  has_many :characters
end
