require_relative '../spec_helper'

require 'pp'

describe "Password Strategy" do
  def app
    Rack::Builder.new do
      use Warden::Manager do |config|
        config.default_strategies :test
      end
      
      run Sinatra::Application
    end
  end
  
  context "when checking if the call is valid" do
    it "should return true if the username and password have been supplied" do  
      Warden.on_next_request do |proxy|
        @strategy = NinjaFund::Security::PasswordStrategy.new(proxy.env)
      end
      get '/', :username => 'user', :password => 'password'
      @strategy.valid?.should be_true
    end

    it "should return true if only the password has been supplied" do
      Warden.on_next_request do |proxy|
        @strategy = NinjaFund::Security::PasswordStrategy.new(proxy.env)
      end
      get '/', :password => 'password'
      @strategy.valid?.should be_true
    end
       
    it "should return true if only the username has been supplied" do
      Warden.on_next_request do |proxy|
        @strategy = NinjaFund::Security::PasswordStrategy.new(proxy.env)
      end
      get '/', :username => 'user'
      @strategy.valid?.should be_true
    end
    
    it "should return false if neither the password nor the username have been supplied" do
      Warden.on_next_request do |proxy|
        @strategy = NinjaFund::Security::PasswordStrategy.new(proxy.env)
      end
      get '/'
      @strategy.valid?.should be_false
    end
  end
end
