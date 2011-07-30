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
    PricingPlan.create([{:plan_name=>"Basic",:amount=>20,:transaction_fee=>3,:no_of_products=>15,:payment_period=>"Monthly",:is_active=>1},
      {:plan_name=>"Gold",:amount=>100,:transaction_fee=>2,:no_of_products=>35,:payment_period=>"Monthly",:is_active=>1},
    {:plan_name=>"Silver",:amount=>50,:transaction_fee=>2.5,:no_of_products=>25,:payment_period=>"Monthly",:is_active=>1},
    {:plan_name=>"Platinum",:amount=>250,:transaction_fee=>1,:no_of_products=>45,:payment_period=>"Monthly",:is_active=>1}])
  end

  def self.down
    drop_table :pricing_plans
  end
end
