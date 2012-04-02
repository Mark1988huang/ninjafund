module NinjaFund
  module Routes
    class Application < Base
      get '/logon' do
        redirect '/' if warden.authenticated?
        
        erb :logon
      end
      
      post '/logon' do
        redirect '/' if warden.authenticated? 
        
        redirect (session.delete(:return_to) || '/') if warden.authenticate?

        erb :logon, :locals => { :error_message => warden.message }
      end
      
      get %r{^(?=(/?)(.*))((?!session|assets|api).)*$} do
        if warden.unauthenticated?
          session[:return_to] = request.path if request.path != '/'
          redirect '/logon'
        end
        
        erb :index
      end
    end
  end
end
