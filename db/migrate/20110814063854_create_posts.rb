class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :game_id
      t.integer :user_id
      t.datetime :posted
      t.text :message
      t.string :action

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
