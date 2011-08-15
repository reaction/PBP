# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.delete_all
Game.delete_all

User.create(:username => 'reaction', :id => 1, :password => 'futeki18', :email => 'mastersofevil@gmail.com',
 :address1 => '635 Dunlap St.', :city => 'Lansing', :state => 'MI', 
 :admin => true)
 Game.create(:system => 'Test System', :name => 'Test Game', :open => 'true', :gm => 'reaction', :creator => 1)
