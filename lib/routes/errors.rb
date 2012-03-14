module NinjaFund
  module Routes
    class Errors < Base
      error do
        erb :'500'
      end
      
      not_found do
        erb :'404'
      end
    end
  end
end
