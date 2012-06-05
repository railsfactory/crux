# This migration comes from spree (originally 20110624083705)
class AddColumnsToStoreOwners < ActiveRecord::Migration
  def self.up
    add_column :spree_storeowner_orders, :is_custom, :boolean
  end

  def self.down
    remove_column :spree_storeowner_orders, :is_custom
  end
end
