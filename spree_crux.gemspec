# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_crux'
  s.version     = '1.1.0'
  s.summary     = 'Crux is the extension of spree CMS.'
  s.description = 'Crux enables creation of separate On-Line store for paid registered users.'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'RailsFactory'
  s.email             = 'spree@railsfactory.org'
  s.homepage          = 'http://www.railsfactory.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.1.0'

  s.add_development_dependency 'capybara', '1.0.1'
  s.add_development_dependency 'factory_girl', '~> 2.6.4'
  s.add_development_dependency 'ffaker'	
  s.add_development_dependency 'rspec-rails',  '~> 2.9'
  s.add_development_dependency 'sqlite3'
end
