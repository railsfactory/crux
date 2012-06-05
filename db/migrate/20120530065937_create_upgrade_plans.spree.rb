# This migration comes from spree (originally 20110712120340)
class CreateUpgradePlans < ActiveRecord::Migration
  def self.up
    create_table :spree_upgrade_plans do |t|
     t.integer :store_owner_id
		 t.integer :plan_id
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_upgrade_plans
  end
end
