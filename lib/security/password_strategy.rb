require 'pp'
module NinjaFund
  module Security
    class PasswordStrategy < Warden::Strategies::Base
      def valid?
        params['username'] || params['password']
      end
      
      def authenticate! 
      end
    end
  end
end
