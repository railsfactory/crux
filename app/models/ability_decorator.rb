Ability.class_eval do
def initialize(user)
    self.clear_aliased_actions

    # override cancan default aliasing (we don't want to differentiate between read and index)
    alias_action :edit, :to => :update
    alias_action :new, :to => :create
    alias_action :new_action, :to => :create
    alias_action :show, :to => :read

    user ||= User.new
    if user.has_role? 'admin'
      can :manage, :all
			elsif user.has_role? 'storeowner'
       can :manage, :all
			 cannot [:index], [PricingPlan]
    else
      #############################
      can :read, User do |resource|
        resource == user
      end
      can :update, User do |resource|
        resource == user
      end
      can :create, User
      #############################
      can :read, Order do |order, token|
        order.user == user || order.token && token == order.token
      end
      can :update, Order do |order, token|
        order.user == user || order.token && token == order.token
      end
      can :create, Order
      #############################
      can :read, Product
      can :index, Product
      #############################
      can :read, Taxon
      can :index, Taxon
      #############################
    end

    #include any abilities registered by extensions, etc.
    Ability.abilities.each do |clazz|
      ability = clazz.send(:new, user)
      @rules = rules + ability.send(:rules)
    end

  end
	end