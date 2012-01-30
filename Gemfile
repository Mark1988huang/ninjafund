# define the sources for the Gem files
source 'http://rubygems.org'

# declare base dependencies
gem 'sinatra', 
  '1.3.2', 
  :require => 'sinatra/base'
gem 'sinatra-contrib', '1.3.1'
gem 'thin', '1.3.1'
gem 'rack-ssl', 
  '1.3.2', 
  :require => 'rack/ssl'
gem 'warden', '1.1.0'

# setup the development group dependencies
group :development do
  gem 'shotgun', '0.9'
  gem 'jammit-sinatra',
  	:git => 'git://github.com/joesteele/jammit-sinatra.git', 
  	:require => 'jammit/sinatra' 
  gem 'barista', '1.2.1'
  gem 'therubyracer', '0.9.9'
end

# setup the test group dependencies
group :test do
  gem 'rspec'
end  
