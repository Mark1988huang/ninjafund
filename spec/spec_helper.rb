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
  
  DataMapper.setup :default, 'sqlite3::memory:'

  conf.before(:each) do
    Warden.test_mode!
    DataMapper.auto_migrate!
  end

  conf.after(:each) do 
    Warden.test_reset!
  end
end
