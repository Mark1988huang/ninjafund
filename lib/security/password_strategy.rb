module NinjaFund
  module Security
    class PasswordStrategy < Warden::Strategies::Base
      def valid?
        params['username'] || params['password']
      end
      
      def authenticate! 
        u = NinjaFund::Model::User.first(:email => params['username'])
        (u.nil? || u.password != params['password']) ? fail!('The supplied username or password was invalid.') : success!(u)
      end
    end
  end
end
