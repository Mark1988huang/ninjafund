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
      u1 = NinjaFund::Model::User.new; u1.id, u1.email, u1.name = 1, 'test1@test.com', 'test 1'
      u2 = NinjaFund::Model::User.new; u2.id, u2.email, u2.name = 2, 'test2@test.com', 'test 2'
      u3 = NinjaFund::Model::User.new; u3.id, u3.email, u3.name = 3, 'test3@test.com', 'test 3'
      NinjaFund::Model::User.expects(:all).returns [ u1, u2, u3 ]
      
      @expected = [ u1, u2, u3 ].to_json
      
      get 'api/v1/users'
      last_response.should be_ok
      last_response.body.should == @expected
    end
  end
end
