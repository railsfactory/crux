Spree
====

Introduction goes here.

Clone the git repo   
git clone -b 0-60-stable git://github.com/spree/spree.git

cd spree

Install the gem dependencies
bundle install

Create a sandbox rails application for testing purposes (and automatically perform all necessary database setup)
bundle exec rake sandbox
cd sandbox

Install the gem dependencies supported for sandbox
bundle install

Now you just need to create new database
bundle exec rake db:create

Then use the install generator to do the basic setup (Copies all migrations and assets)
bundle exec rake spree:install

Now you just need to run the new migrations, and setup some basic data
bundle exec rake db:migrate
bundle exec rake db:seed

Now just loads sample data into the store
bundle exec rake db:sample

Crux
====

Introduction goes here.


Crux is the extension of spree CMS. A separate On-Line store will be created for paid registered users.Three kind of users with roles named as Super-Admin, Admin, and Normal
User. Super Admin is the one who has ability to manage the domain. Store owners can register
And start their own store. Each store will operate as a unique business and will have a custom
domain name and branding. Store owner can act as admin for his domain and he can set his
Personalised configurations for his shop.

Add to the following gem dependency in sandbox/Gemfile
gem "crux",:git => "git://github.com/railsfactory/crux.git"
gem 'subdomain-fu', '1.0.0.beta2', :git => "git://github.com/nhowell/subdomain-fu.git"
gem 'dynamic_form'
gem 'geokit'

Run
cd sandbox
bundle install
bundle exec rake spree_core:install
bundle exec rake crux:install
bundle exec rake db:migrate

Add the settings.yml file in sandbox/config






For instance:
====

development/production:
domain_url: http://yourdomain.com (eg:http://shop.storefront.com)
secure_domain_url: https://yourdomain.com (eg:https://shop.storefront.com)
sub_domain: yoursubdomain (eg:shop)
separate_url: yourdomain (eg:shop.storefront)

Note:
====

Super-Admin:spree sample user.
Before register any store, the store registration payment method  should be updated in admin/configuration panel by super admin. Then only the store can be registered.
DNS Subdomain Configuration

Example
=======

Example goes here.


Copyright (c) 2011 [name of extension creator], released under the New BSD License

