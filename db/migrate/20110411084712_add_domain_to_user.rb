class AddDomainToUser < ActiveRecord::Migration
  def self.up
  add_column :users,:is_owner,:boolean
  end

  def self.down
	remove_column :users,:is_owner
  end
end
