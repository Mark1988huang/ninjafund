require_relative '../spec_helper'

describe "The basic application" do
  def app
    Rack::Builder.app do
      # enable sessions for the application
      use Rack::Session::Cookie, :secret => '732c1db7478b81d72465c55cc6940f46'
      
      # setup the mock warden authenticastion
      use Warden::Manager do |manager|
        manager.default_strategies :password
      end
      
	    # load the Sinatra application modules using the cascaded configuration
      run NinjaFund::Routes::Application
    end
  end

  context "when getting the logon page" do
    context "and the request is not authenticated" do
      it "should return the logon page" do
        get '/logon'
        last_response.should be_ok
        
        path = File.expand_path '../../public/logon.html', File.dirname(__FILE__)
        expected = File.open( path ).read
        last_response.body.should == expected
      end
    end
    
    context "and the request is authenticated" do
      it "should redirect to the site root" do
        u = NinjaFund::Model::User.new; u.id, u.email = 1, 'test@test.com'
        login_as u
        
        get '/logon'
        last_response.should be_redirect; follow_redirect!
        last_request.url.should == "http://example.org/"
     end  
    end
  end
  
  context "when getting the root url" do
    context "and the request is not authenticated" do
      it "should redirect to the logon page" do
        get '/'
        last_response.should be_redirect; follow_redirect!
        last_request.url.should == "http://example.org/logon"
      end
      
      context "and the request was for a path beyond the root" do
        it "should redirect to the logon page" do
          get '/test'
          last_response.should be_redirect; follow_redirect!
          last_request.url.should == "http://example.org/logon"
        end
        
        it "should store the attempted route in the session variables" do
          get '/test'
          
          session = last_request.env['rack.session']
          session[:return_to].should == '/test'
        end
      end
    end
    
    context "and the request is authenticated" do
      before(:each) do
        u = NinjaFund::Model::User.new; u.id, u.email = 1, 'test@test.com'
        login_as u
      end
    
      it "should return the site index page" do
        get '/'
        last_response.should be_ok
        
        path = File.expand_path '../../public/index.html', File.dirname(__FILE__)
        expected = File.open( path ).read
        last_response.body.should == expected
      end
    end   
  end
  
  context "when logging in" do
    context "and the request is authenticated" do
      before(:each) do 
        u = NinjaFund::Model::User.new; u.id, u.email = 1, 'test@test.com'
        login_as u
      end
        
      it "should redirect to the site root" do
        post '/logon'
        last_response.should be_redirect; follow_redirect!
        last_request.url.should == 'http://example.org/'
      end   
    end   
    
    context "and the request is not authenticated" do
      context "and the specified user does not exist" do
        it "should return the view " do
          NinjaFund::Model::User.expects(:find).with(:email => 'invalid').returns(nil)
          
          post '/logon', :username => 'invalid'
          last_response.should be_ok 
        end
      end
    end
  end
end