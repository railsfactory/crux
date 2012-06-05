# This migration comes from spree (originally 20110614103832)
class AddNewRoleToRoles < ActiveRecord::Migration
  def self.up
		Spree::Role.create!(:name=>"storeowner")
  end

  def self.down
  end
end
