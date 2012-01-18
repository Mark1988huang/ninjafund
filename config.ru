require 'rubygems'
require 'bundler/setup'

# load all of the default required libraries
Bundler.require(:default, ENV['RACK_ENV'])

# load the application files for the site
require './lib/ninjafund'

# load all of the routes using the cascade mechanism
run Rack::Cascade.new [NinjaFund::Application, NinjaFund::Security]
