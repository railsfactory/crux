class AddNewRoleToRoles < ActiveRecord::Migration
  def self.up
		Role.create!(:name=>"storeowner")
  end

  def self.down
  end
end
