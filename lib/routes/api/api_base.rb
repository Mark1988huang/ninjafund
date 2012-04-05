module NinjaFund::Routes::API
  class ApiBase < NinjaFund::Routes::Base
    before '/api/*' do 
      # TODO: Add authentication for OAUTH 2.0.
      content_type :json;
    end
  end
end
