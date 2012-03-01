module NinjaFund
  module Security
    class PasswordStrategy < Warden::Strategies::Base
      def valid?
        (params[:username] || params[:password]) unless params.nil?
      end
      
      def authenticate! 
      end
    end
  end
end
