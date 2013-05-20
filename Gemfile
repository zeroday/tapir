source 'http://rubygems.org'

# Require recent Rails:
gem 'rails' # Latest gem
# Use edge Rails instead:
#gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Rails / Database
gem 'therubyracer'
gem 'formtastic', :git => 'git://github.com/justinfrench/formtastic.git', :branch => '2.1-stable'
gem 'formtastic-bootstrap', :git => 'https://github.com/cgunther/formtastic-bootstrap.git', :branch => 'bootstrap2-rails3-2-formtastic-2-1'
gem 'tabulous', "~> 1.3.2" 

# Mongo Database
gem "mongoid", "~> 3.0.0"
gem 'mongoid-multitenancy'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 2.0.0'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-datatables-rails', :git => 'https://github.com/rweng/jquery-datatables-rails'
gem 'will_paginate'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

######################
#  Data manipulation #
######################
gem 'fastercsv'
gem 'librex'
gem 'nmap-parser'
gem 'json'

# Data Formats
gem 'exifr'

# Network Services
gem 'dnsruby'
gem 'geoip'
gem 'whois'
gem 'packetfu'
gem 'pcaprub'

# Web Services
gem 'linkedin'
gem 'flickr'

# Debugging 
gem 'pry'
gem 'pry-rails'
gem 'pry-nav'

# Scraping
gem 'mechanize'
gem 'nokogiri'
gem 'googleajax'
gem 'open_uri_redirections'

# Heavy-duty javascript scraping
gem 'selenium-webdriver' # browser based scraping with capybara
gem 'capybara'

# Infrastructure
gem 'fog'

group :pain do
  
  # Requires QTwebkit
  # https://github.com/thoughtbot/capybara-webkit#readme
  # If you're on ubuntu, you'll need to run: apt-get install libqt4-dev
  gem 'capybara-webkit'
end

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end
