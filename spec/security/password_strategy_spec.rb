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
  
  before(:each) do
    Warden.on_next_request do |proxy|
      @strategy = NinjaFund::Security::PasswordStrategy.new(proxy.env)
    end
  end
    
  context "when checking if the call is valid" do
    it "should return true if the username and password have been supplied" do  
      get '/', :username => 'user', :password => 'password'
      
      @strategy.valid?.should be_true
    end

    it "should return true if only the password has been supplied" do
      get '/', :password => 'password'
      
      @strategy.valid?.should be_true
    end
       
    it "should return true if only the username has been supplied" do
      get '/', :username => 'user'
      
      @strategy.valid?.should be_true
    end
    
    it "should return false if neither the password nor the username have been supplied" do
      get '/'
      
      @strategy.valid?.should be_false
    end
  end
  
  context "when attempting to authenticate a request" do
    it "should fail if the user cannot be found" do
      get '/', :username => 'test@test.com', :password => 'password'
      
      NinjaFund::Model::User.expects(:first).with(:email => 'test@test.com').returns(nil)
      
      @strategy.authenticate!; @strategy.result.should == :failure
    end
    
    it "should fail if the password is incorrect" do
      get '/', :username => 'test@test.com', :password => 'incorrect'
      
      u = NinjaFund::Model::User.new; u[:email], u[:password] = 'test@test.com', 'password'      
      NinjaFund::Model::User.expects(:first).with(:email => 'test@test.com').returns(u)
      
      @strategy.authenticate!; @strategy.result.should == :failure
    end
    
    it "should be successful when the password is correct" do
      get '/', :username => 'test@test.com', :password => 'password'
     
      u = NinjaFund::Model::User.new; u[:email], u[:password] = 'test@test.com', 'password'      
      NinjaFund::Model::User.expects(:first).with(:email => 'test@test.com').returns(u)
      
      @strategy.authenticate!; @strategy.result.should == :success
    end
  end
end
