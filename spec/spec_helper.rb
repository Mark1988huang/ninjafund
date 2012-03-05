ENV['RACK_ENV'] ||= 'test'

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'rack/test'
require 'bcrypt'

set :environment, :test
  
Bundler.require :default, :test

require 'mocha'

begin 
  require_relative '../lib/ninjafund'
rescue NameError
  require File.expand_path('../../lib/ninjafund', __FILE__)
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Warden::Test::Helpers

  conf.mock_framework = :mocha
end

before{ Warden.test_mode! }

after{ Warden.test_reset! }
