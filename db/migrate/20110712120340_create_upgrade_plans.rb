class CreateUpgradePlans < ActiveRecord::Migration
  def self.up
    create_table :upgrade_plans do |t|
     t.integer :store_owner_id
		 t.integer :plan_id
      t.timestamps
    end
  end

  def self.down
    drop_table :upgrade_plans
  end
end
