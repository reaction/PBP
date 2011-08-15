class AddSystemToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :system, :string
  end

  def self.down
    remove_column :games, :system
  end
end
