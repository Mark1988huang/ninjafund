module NinjaFund
  module Routes
    class Session < Base
      before '/session/*' do 
        redirect '/logon' if warden.unauthenticated?
      end
      
      get '/session/profile' do
        u = warden.user; content_type :json
        { id: u.id, email: u.email, name: u.name }.to_json
      end
      
      get '/session/logout' do
        warden.logout if warden.authenticated?
      end
    end
  end
end