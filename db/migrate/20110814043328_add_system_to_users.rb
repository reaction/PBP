class AddSystemToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :system, :string
  end

  def self.down
    remove_column :users, :system
  end
end
