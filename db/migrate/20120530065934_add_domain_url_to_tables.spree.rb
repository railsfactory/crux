# This migration comes from spree (originally 20110614115322)
class AddDomainUrlToTables < ActiveRecord::Migration
def self.up
add_column :spree_mail_methods,:domain_url,:string
add_column :spree_option_types,:domain_url,:string
add_column :spree_payment_methods,:domain_url,:string
#add_column :spree_product_groups,:domain_url,:string
add_column :spree_properties,:domain_url,:string
add_column :spree_prototypes,:domain_url,:string
add_column :spree_shipping_categories,:domain_url,:string
add_column :spree_shipping_methods,:domain_url,:string
add_column :spree_taxonomies,:domain_url,:string
add_column :spree_taxons,:domain_url,:string
add_column :spree_tax_categories,:domain_url,:string
add_column :spree_tax_rates,:domain_url,:string
add_column :spree_zones,:domain_url,:string
add_column :spree_preferences,:domain_url,:string
add_column :spree_products,:domain_url,:string
#~ add_column :activators,:domain_url,:string
add_column :spree_users,:domain_url,:string
end

def self.down
remove_column :spree_mail_methods,:domain_url
remove_column :spree_option_types,:domain_url
remove_column :spree_payment_methods,:domain_url
#remove_column :spree_product_groups,:domain_url
remove_column :spree_properties,:domain_url
remove_column :spree_prototypes,:domain_url
remove_column :spree_shipping_categories,:domain_url
remove_column :spree_shipping_methods,:domain_url
remove_column :spree_taxonomies,:domain_url
remove_column :spree_taxons,:domain_url
remove_column :spree_tax_categories,:domain_url
remove_column :spree_tax_rates,:domain_url
remove_column :spree_zones,:domain_url
remove_column :spree_preferences,:domain_url
remove_column :spree_products,:domain_url
remove_column :spree_activators,:domain_url
remove_column :spree_users,:domain_url
end
end
