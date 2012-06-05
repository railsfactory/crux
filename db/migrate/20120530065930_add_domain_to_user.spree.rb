# This migration comes from spree (originally 20110411084712)
class AddDomainToUser < ActiveRecord::Migration
  def self.up
  add_column :spree_users,:is_owner,:boolean
  end

  def self.down
	remove_column :spree_users,:is_owner
  end
end
