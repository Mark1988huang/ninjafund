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
      u = NinjaFund::Model::User.new; u.attributes = params
      
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
  end
end
