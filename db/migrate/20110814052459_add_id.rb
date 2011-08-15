class AddId < ActiveRecord::Migration
def self.up
add_column :users, :id, :primary_key
end

def self.down
remove_column :users, :id
end
end
