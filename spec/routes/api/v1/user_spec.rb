require_relative '../../../spec_helper'

describe "the users api (v1) interface" do
  include Rack::Test::Methods
  
  def app
    Rack::Builder.app do
      # enable sessions for the application
      use Rack::Session::Cookie,
        :key => 'rack.session',
        :secret => '732c1db7478b81d72465c55cc6940f46'
      
      # load the Sinatra application modules using the cascaded configuration
      run NinjaFund::Routes::API::V1::Users
    end
  end

  context "when retrieving a list of users" do
    it "should return all of the users in the database" do
      u1 = NinjaFund::Model::User.create :email => 'test1@test.com', :name => 'test 1', :password => 'password'
      u2 = NinjaFund::Model::User.create :email => 'test2@test.com', :name => 'test 2', :password => 'password'
      u3 = NinjaFund::Model::User.create :email => 'test3@test.com', :name => 'test 3', :password => 'password'
      
      @expected = { :users => [ 
        { :id => u1.id, :name => u1.name, :email => u1.email }, 
        { :id => u2.id, :name => u2.name, :email => u2.email }, 
        { :id => u3.id, :name => u3.name, :email => u3.email }
      ]}.to_json
      
      get 'api/v1/users'
      last_response.should be_ok
      last_response.body.should == @expected
    end
  end
  
  context "when creating a new user" do
    it "should return an error when no e-mail address has been supplied" do
      post '/api/v1/users', { 
        :name => 'test user',
        :password => 'password'
      }
      
      @expected = { 
        :status => 400, 
        :message => 'Email', 
        :code => 10001  
      }.to_json
      
      last_response.should_not be_ok
      last_response.status.should == 400
      last_response.body.should == @expected
    end
    
    it "should return an error when the specified e-mail address is in user" do
      NinjaFund::Model::User.create :email => 'test@test.com', :name => 'test', :password => 'password'
      
      post '/api/v1/users', { 
        :name => 'test user',
        :email => 'test@test.com',
        :password => 'password'
      }
      
      @expected = { 
        :status => 400, 
        :message => 'Email', 
        :code => 10002  
      }.to_json
      
      last_response.should_not be_ok
      last_response.status.should == 400
      last_response.body.should == @expected
    end
    
    it "should return an error when the specified e-mail address is invalid" do
      post '/api/v1/users', { 
        :name => 'test user',
        :email => 'test',
        :password => 'password'
      }
      
      @expected = { 
        :status => 400, 
        :message => 'Email', 
        :code => 10003  
      }.to_json
      
      last_response.should_not be_ok
      last_response.status.should == 400
      last_response.body.should == @expected
    end
    
    it "should return an error when the user name is not supplied" do
      post '/api/v1/users', { 
        :email => 'test@test.com',
        :password => 'password'
      }
      
      @expected = { 
        :status => 400, 
        :message => 'Name', 
        :code => 10004  
      }.to_json
      
      last_response.should_not be_ok
      last_response.status.should == 400
      last_response.body.should == @expected
    end
    
    it "should return an error when the user name is too long" do
      post '/api/v1/users', { 
        :email => 'test@test.com',
        :name => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras at nibh lectus, vitae pellentesque orci. Proin sit amet lectus sed.',
        :password => 'password'
      }
      
      @expected = { 
        :status => 400, 
        :message => 'Name', 
        :code => 10005  
      }.to_json
      
      last_response.should_not be_ok
      last_response.status.should == 400
      last_response.body.should == @expected
    end
    
    it "should return an error when the password is not supplied" do
      post '/api/v1/users', { 
        :email => 'test@test.com',
        :name => 'Test'
      }
      
      @expected = { 
        :status => 400, 
        :message => 'Password', 
        :code => 10006  
      }.to_json
      
      last_response.should_not be_ok
      last_response.status.should == 400
      last_response.body.should == @expected
    end
    
    it "should return the details of the newly created user" do
      post '/api/v1/users', { 
        :email => 'test@test.com',
        :name => 'Test',
        :password => 'password'
      }
      
      u = NinjaFund::Model::User.first; @expected = { 
        :user => { :id => u.id, :name => u.name, :email => u.email }
      }.to_json
      
      last_response.should be_ok
      last_response.body.should == @expected
    end
  end
  
  context "when deleting a user" do
    it "should return an error when the user cannot be found" do
      delete '/api/v1/users/1'
      
      @expected = {
        :status => 400,
        :message => 'Id',
        :code => 10007
      }.to_json
      
      last_response.should_not be_ok
      last_response.body.should == @expected
    end
    
    it "should remove the user" do
      u = NinjaFund::Model::User.create :email => 'test@test.com', :name => 'test', :password => 'password'
      
      delete "/api/v1/users/#{u.id}"
      
      last_response.should be_ok
      NinjaFund::Model::User.all().length.should == 0    
    end
  end
end
