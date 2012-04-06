# define the sources for the Gem files
source 'http://rubygems.org'

# declare base dependencies
gem 'sinatra', 
  '1.3.2', 
  :require => ['sinatra/base', 'sinatra' ]
gem 'sinatra-contrib', '1.3.1'
gem 'sinatra-assetpack', 
  '0.0.11',
  :require => 'sinatra/assetpack' 
gem 'thin', '1.3.1'
gem 'rack-ssl', 
  '1.3.2', 
  :require => 'rack/ssl'
gem 'warden', '1.1.0'
gem 'data_mapper', '1.2.0'
gem 'dm-mysql-adapter'
gem 'json'

# setup the development group dependencies
group :development do
  gem 'shotgun', '0.9'
  gem 'guard-coffeescript'
  gem 'therubyracer', '0.9.9'
end

# setup the development/test group dependencies
group :development, :test do
  gem 'jammit'
  gem 'jammit-sinatra',
    :git => 'git://github.com/joesteele/jammit-sinatra.git', 
    :require => 'jammit/sinatra'
end

# setup the test group dependencies
group :test do
  gem 'rack-test', 
    '0.6.1',
    :require => 'rack/test'
  gem 'rspec',
    '2.8.0',
    :require => 'rspec/expectations'
  gem 'watchr', '0.7'
  gem 'guard', '1.0.0'
  gem 'guard-bundler', '0.1.3'
  gem 'guard-rspec', '0.6.0'
  gem 'growl', '1.0.3'
  #gem 'libnotify', '0.7.2'
  gem 'mocha', 
    '0.10.4', 
    :require => false
  gem 'jasmine', '1.1.2'
end  
