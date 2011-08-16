class Ability
  include CanCan::Ability
      
  def initialize(user)  
    user ||= User.new  
    can :index, :all
    if user.admin?  
      can :admin, :all  
    else  
      can :read, :all    
      end    
        can :create, Post  
        can :update, Post do |post|  
          post.try(:user) == user  
        end  
      end  
    end  
  end  
end