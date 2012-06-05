# This migration comes from spree (originally 20110713071659)
class CreateStoreRegPaymentMethods < ActiveRecord::Migration
  def self.up
    create_table :spree_store_reg_payment_methods do |t|
      t.string :username
			t.string :password
			t.string :signature
			t.timestamps
    end
  end

  def self.down
    drop_table :spree_store_reg_payment_methods
  end
end
