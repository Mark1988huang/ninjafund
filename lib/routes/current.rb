module NinjaFund
  module Routes
    class Current < Base
      before '/current/*' do 
        redirect '/logon' if warden.unauthenticated?
      end
      
      get '/current/user' do
        u = warden.user; content_type :json
        { id: u.id, email: u.email, name: u.name }.to_json
      end
    end
  end
end