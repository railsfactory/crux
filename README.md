Saas
====

Introduction goes here.

Clone the spree application and follow the procedure to install the spree.

Then add following gems in the sandbox/gem file,

Used to integrate the spree application based on domain.

gem "saas", :git => 'git@github.com:railsfactory/spree-SaaS.git'

Used to create a saas with subdomains.

gem 'subdomain-fu', '1.0.0.beta2', :git => "git://github.com/nhowell/subdomain-fu.git" 

Used for default validation process.

gem 'dynamic_form' 

Use the following steps to update the gems and spree 

bundle install ~

bundle exec rake spree_core:install

bundle exec rake saas:install

bundle exec rake db:migrate

Remove the index.html in sandbox/public

Paypal and domain configuration
================================

Create a settings.yml file inside sandbox/config

Inside sandbox/config/settings.yml

For instance :
=================

development:

  domain_url: http://yourdomain.com

 //To use as a secured http

  secure_domain_url: https://yourdomain.com
  separate_url: shop

 //paypal details(sandbox account)

  paypal_username: your login id
  paypal_password: your password
  paypal_signature: your signature

production:

 //For production environment,provide your details as like in development

 For payment recurring through paypal ,there is an availability of rake task inside /lib/tasks/saas.rake

 Rake task can be run with the help of command "bundle exec rake paypal_recurring:get_money"

 Rake task can also be run as  background job with CRON TAB

Copyright (c) 2011 [name of extension creator], released under the New BSD License