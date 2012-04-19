require 'pp'
module NinjaFund::Routes::API::V1
  class Users < NinjaFund::Routes::API::ApiBase
    get '/api/v1/users' do
      @data = NinjaFund::Model::User.all().map { |u| { 
        :id => u.id,
        :name => u.name,
        :email => u.email
      }}
      
      { :users => @data }.to_json
    end
    
    post '/api/v1/users' do
      # Check whether the request is a JSON request or a normal request.
      data = File.fnmatch('*/json', request.content_type) ? 
        JSON.parse(request.body.read) : 
        params
      
      # Validate the passowrd before it has been set.
      if data['password'] && data['password'].length < 8
        status 400; return {
          :status => 400,
          :message => 'Password',
          :code => 10007
        }.to_json
      end
      
      # Initialize the object with the retrieved parameters for the request.
      u = NinjaFund::Model::User.new(
        :email => (data['email'] || '').downcase, 
        :password => data['password'], 
        :name => data['name']
      )
      
      # Attempt to validate the object before saving it.
      unless u.save
        # Return the errors from the validation of the object,
        status 400; error = u.errors.to_a()[0][0]
        return {
          :status => 400,
          :message => error[:message],
          :code => error[:code]
        }.to_json
      end
      
      # Return the serialized version of the initialized object.
      { :user => {
        :id => u.id,
        :name => u.name,
        :email => u.email
      }}.to_json
    end
    
    delete '/api/v1/users/:id' do
      # Attempt to retrieve the user with the supplied ID.
      u = NinjaFund::Model::User.get params[:id]
      
      # Return an error code if the user cannot be found.
      unless u
        status 400; return {
          :status => 400,
          :message => 'Id',
          :code => 10008
        }.to_json
      end
      
      # Delete the user and return a HTTP 200 by default.
      u.destroy
    end
  end
end
