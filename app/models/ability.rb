class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
      #can :admin, :all
      can :index, :all
    if user.admin == "true"
      can :admin, :all
      
    end
  end
end