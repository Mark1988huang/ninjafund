# define the sources for the Gem files
source 'http://rubygems.org'

# declare base dependencies
gem 'sinatra', :require => 'sinatra/base'
gem 'sinatra-contrib'

# use the Thin web-server.
gem 'thin'

# setup the development group dependencies
group :development do
  gem 'shotgun'
  gem 'jammit-sinatra', :git => 'git://github.com/joesteele/jammit-sinatra.git', :require => 'jammit/sinatra' 
  gem 'barista'
  gem 'therubyracer'
end

# setup the test group dependencies
group :test do
  gem 'rspec'
end  
