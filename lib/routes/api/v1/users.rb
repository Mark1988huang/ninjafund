module NinjaFund::Routes::API::V1
  class Users < NinjaFund::Routes::API::ApiBase
    get '/api/v1/users' do
      @data = NinjaFund::Model::User.all().map { |u| { 
        :id => u.id,
        :name => u.name,
        :email => u.email
      }}
      
      @data.to_json
    end
  end
end
