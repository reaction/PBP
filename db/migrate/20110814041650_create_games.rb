class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :name
      t.boolean :open
      t.text :variables
      t.string :gm

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
