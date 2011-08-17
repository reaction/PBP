class AddHiddenToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :hidden, :boolean, :default => 0
  end

  def self.down
    remove_column :games, :hidden
  end
end
