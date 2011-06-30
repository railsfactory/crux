class AddDomainUrlToTables < ActiveRecord::Migration
def self.up
add_column :mail_methods,:domain_url,:string
add_column :option_types,:domain_url,:string
add_column :payment_methods,:domain_url,:string
add_column :product_groups,:domain_url,:string
add_column :properties,:domain_url,:string
add_column :prototypes,:domain_url,:string
add_column :shipping_categories,:domain_url,:string
add_column :shipping_methods,:domain_url,:string
add_column :taxonomies,:domain_url,:string
add_column :taxons,:domain_url,:string
add_column :tax_categories,:domain_url,:string
add_column :tax_rates,:domain_url,:string
add_column :zones,:domain_url,:string
add_column :preferences,:domain_url,:string
add_column :products,:domain_url,:string
add_column :activators,:domain_url,:string
add_column :users,:domain_url,:string
end

def self.down
remove_column :mail_methods,:domain_url
remove_column :option_types,:domain_url
remove_column :payment_methods,:domain_url
remove_column :product_groups,:domain_url
remove_column :properties,:domain_url
remove_column :prototypes,:domain_url
remove_column :shipping_categories,:domain_url
remove_column :shipping_methods,:domain_url
remove_column :taxonomies,:domain_url
remove_column :taxons,:domain_url
remove_column :tax_categories,:domain_url
remove_column :tax_rates,:domain_url
remove_column :zones,:domain_url
remove_column :preferences,:domain_url
remove_column :products,:domain_url
remove_column :activators,:domain_url
remove_column :users,:domain_url
end
end
