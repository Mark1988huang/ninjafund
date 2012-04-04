require_relative '../spec_helper'

describe "The basic application" do
  include Sinatra::Templates
  include Rack::Test::Methods
  
  attr_accessor :template_cache
  
  def app
    @template_cache = Tilt::Cache.new
    
    Rack::Builder.app do
      # enable sessions for the application
      use Rack::Session::Cookie,
        :key => 'rack.session',
        :secret => '732c1db7478b81d72465c55cc6940f46'
      
      # setup the mock warden authenticastion
      use Warden::Manager do |manager|
        manager.default_strategies :default
      end
      
      Warden::Strategies.add :default, NinjaFund::Security::PasswordStrategy
      
      # set the location of the views for the application.
      set :views, File.expand_path( '../../views', File.dirname(__FILE__) )
      
      # load the Sinatra application modules using the cascaded configuration
      run NinjaFund::Routes::Session
    end
  end
  
  context "when getting the user's profile details" do
    it "should return the logon page if the request is not authenticated" do
      get '/session/profile'      
      
      last_response.should be_redirect; follow_redirect!
      last_request.url.should == "http://example.org/logon"
    end
    
    it "should return the json details for the user if the request is authenticated" do
      u = NinjaFund::Model::User.new; u.id, u.email, u.name = 1, 'test@test.com', 'test'
      login_as u
      
      @expected = { 
        :id => 1,
        :email => 'test@test.com',
        :name => 'test'
      }.to_json
      
      get '/session/profile'
      last_response.should be_ok
      last_response.body.should == @expected
    end
  end
  
  context "when logging the user out" do
    it "should return the logon page if the request is not authenticated" do
      get '/session/logout'      
      
      last_response.should be_redirect; follow_redirect!
      last_request.url.should == "http://example.org/logon"
    end
    
    it "should terminate the user's session if the request is authenticated" do
      u = NinjaFund::Model::User.new; u.id, u.email, u.name = 1, 'test@test.com', 'test'
      login_as u

      get '/session/logout'
      last_response.should be_ok
      last_request.env[ 'warden' ].should_not be_authenticated
    end
  end
end
