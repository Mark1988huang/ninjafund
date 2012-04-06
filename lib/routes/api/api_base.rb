module NinjaFund::Routes::API
  class ApiBase < NinjaFund::Routes::Base
    before '/api/*' do 
      # TODO: Add authentication for OAUTH 2.0.
      content_type :json;
    end
    
    # When returning errors, the error codes should
    # correspond to the feature group that the processing
    # is occurring for.
    #
    # Groups are as follows:
    #
    #   1XXX - User Administration
  end
end
