ENV['RACK_ENV'] ||= 'test'

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'rspec'
require 'rack/test'

set :environment, :test
Bundler.require :default, :test

require 'capybara/dsl'
require 'capybara/cucumber'

begin 
  require_relative '../lib/ninjafund'
rescue NameError
  require File.expand_path('../../lib/ninjafund', __FILE__)
end

RSpec.configure do |conf|
  conf.include Capybara
  
  Capybara.javascript_driver = :webkit
  
  DataMapper.setup :default, 'sqlite3::memory:'
end

Capybara.app = Rack::Builder.app do
  use Rack::Session::Cookie, 
    :key => 'rack.session',
    :path => '/',
    :secret => '732c1db7478b81d72465c55cc6940f46'

  Warden::Manager.serialize_into_session { |user| user.id }
  Warden::Manager.serialize_from_session { |id| NinjaFund::Model::User.get(id) }
  use Warden::Manager do |config|
    config.default_strategies :default
  end
  Warden::Strategies.add :default, NinjaFund::Security::PasswordStrategy

  run Rack::Cascade.new [ 
    NinjaFund::Routes::Application,
    NinjaFund::Routes::Session,
    NinjaFund::Routes::API::V1::Users,
    NinjaFund::Routes::Errors
  ]
end

Before do
  DataMapper.auto_migrate!
end
