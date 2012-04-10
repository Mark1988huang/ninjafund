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
      u = NinjaFund::Model::User.new(
        :email => (data['email'] || '').downcase, 
        :password => data['password'], 
        :name => data['name']
      )
      
      unless u.save
        status 400; error = u.errors.to_a()[0][0]
        
        return {
          :status => 400,
          :message => error[:message],
          :code => error[:code]
        }.to_json
      end
      
      { :user => {
        :id => u.id,
        :name => u.name,
        :email => u.email
      }}.to_json
    end
    
    delete '/api/v1/users/:id' do
      u = NinjaFund::Model::User.get params[:id]
      
      unless u
        status 400; return {
          :status => 400,
          :message => 'Id',
          :code => 10007
        }.to_json
      end
      
      u.destroy
    end
  end
end
