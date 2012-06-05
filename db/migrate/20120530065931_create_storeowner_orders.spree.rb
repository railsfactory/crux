# This migration comes from spree (originally 20110416115125)
class CreateStoreownerOrders < ActiveRecord::Migration
  def self.up
    create_table :spree_storeowner_orders do |t|
			t.integer :store_owner_id
			t.integer :order_id
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_storeowner_orders
  end
end
