class AddColumnsToBillingHistories < ActiveRecord::Migration
  def self.up
    add_column :billing_histories, :message, :string
    
  end

  def self.down
    remove_column :billing_histories, :message
  end
end
