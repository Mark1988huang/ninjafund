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
      run NinjaFund::Routes::Application
    end
  end

  context "when getting the logon page" do
    it "should return the logon page if the request is not authenticated" do
      get '/logon'
      
      last_response.should be_ok
      last_response.body.should == erb(:logon)
    end
    
    it "should redirect to the site root if the request is authenticated" do
      u = NinjaFund::Model::User.new; u.id, u.email = 1, 'test@test.com'
      login_as u
      
      get '/logon'
      
      last_response.should be_redirect; follow_redirect!
      last_request.url.should == "http://example.org/"
    end
  end
  
  context "when getting the root url" do
    it "should redirect to the logon page if the request is not authenticated" do
      get '/'
      
      last_response.should be_redirect; follow_redirect!
      last_request.url.should == "http://example.org/logon"
    end
    
    it "should return the site index page if the request is authenticated" do
      u = NinjaFund::Model::User.new; u.id, u.email = 1, 'test@test.com'
      login_as u
      
      get '/'
      last_response.should be_ok
      
      path = File.expand_path '../../public/index.html', File.dirname(__FILE__)
      last_response.body.should == File.open( path ).read
    end
  end 
    
  context "when gettig a path beyond the root" do
    it "should store the attempted route in the session variables if the request is not authenticated" do
      get '/test'
      
      session = last_request.env['rack.session']
      session[:return_to].should == '/test'
    end
    
    it "should return the site index page if the request is authenticated" do
      u = NinjaFund::Model::User.new; u.id, u.email = 1, 'test@test.com'
      login_as u

      get '/test'
      last_response.should be_ok

      path = File.expand_path '../../public/index.html', File.dirname(__FILE__)
      last_response.body.should == File.open( path ).read
    end
  end
  
  context "when logging in" do
    it "should redirect to the site root if the request is already authenticated" do
      u = NinjaFund::Model::User.new; u.id, u.email = 1, 'test@test.com'
      login_as u

      post '/logon'

      last_response.should be_redirect; follow_redirect!
      last_request.url.should == 'http://example.org/'
    end   
    
    it "should return the view with an error if the specified user does not exist" do
      NinjaFund::Model::User.expects(:first).with(:email => 'invalid').returns(nil)
      
      post '/logon', :username => 'invalid'
      last_response.should be_ok 
      
      last_response.body.should == erb(:logon, :locals => { :error_message => 'The supplied username or password was invalid.'})
    end
    
    it "shold return the view with an error if the specified password is invalid" do
      u = NinjaFund::Model::User.new; u.id, u.email, u.password = 1, 'test@test.com', 'password'
      NinjaFund::Model::User.expects(:first).with(:email => 'test@test.com').returns(u)
      
      post '/logon', :username => 'test@test.com', :password => 'invalid'
      
      last_response.should be_ok 
      last_response.body.should == erb(:logon, :locals => { :error_message => 'The supplied username or password was invalid.'})
    end

    it "should redirect the user to the root url if the login parameters are valid and there is no redirect url" do
      u = NinjaFund::Model::User.new; u.id, u.email, u.password = 1, 'test@test.com', 'password'
      NinjaFund::Model::User.expects(:first).with(:email => 'test@test.com').returns(u)
      
      post '/logon', :username => 'test@test.com', :password => 'password'
      
      last_response.should be_redirect; follow_redirect!
      last_request.url.should == "http://example.org/"
    end
    
    it "should redirect the user to the proper url if the login paramerts are valid and there is a redirect url" do
      u = NinjaFund::Model::User.new; u.id, u.email, u.password = 1, 'test@test.com', 'password'
      NinjaFund::Model::User.expects(:first).with(:email => 'test@test.com').returns(u)
    
      post '/logon', 
        { :username => 'test@test.com', :password => 'password' }, 
        { 'rack.session' => { :return_to => 'test?id=123' } }
      
      last_response.should be_redirect; follow_redirect!
      last_request.url.should == "http://example.org/test?id=123"
    end
  end
end
