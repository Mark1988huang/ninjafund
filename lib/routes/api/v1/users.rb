module NinjaFund::Routes::API::V1
  class Users < NinjaFund::Routes::API::ApiBase
    get '/api/v1/users' do
      NinjaFund::Model::User.all.to_json
    end
  end
end
