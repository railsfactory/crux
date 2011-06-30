SubdomainFu.configure do |config|
	config.tld_size = 0 # sets for current environment
	config.mirrors = %w(www site we) # Defaults to %w(www)
end