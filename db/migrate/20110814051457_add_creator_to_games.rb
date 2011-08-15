class AddCreatorToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :creator, :integer
  end

  def self.down
    remove_column :games, :creator
  end
end
