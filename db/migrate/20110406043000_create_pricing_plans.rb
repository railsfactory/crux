class CreatePricingPlans < ActiveRecord::Migration
  def self.up
    create_table :pricing_plans do |t|
      t.string :plan_name,:limit=>100
      t.column :amount, :double
      t.column :transaction_fee, :double
      t.integer :no_of_products
      t.string :payment_period,:limit=>40
      t.boolean :is_active,:default=>0
      t.timestamps
    end
  end

  def self.down
    drop_table :pricing_plans
  end
end
