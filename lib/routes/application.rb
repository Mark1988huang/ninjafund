module NinjaFund
  module Routes
    class Application < Base
      get '/logon' do
        redirect '/' if warden.authenticated?
        
        erb :logon
      end
      
      post '/logon' do
        if warden.authenticated? || warden.authenticate?
          redirect session.delete(:return_to) || '/'
        end
        
        erb :logon, :locals => { :error_message => warden.message } 
      end
      
      get // do
        if warden.unauthenticated?
          session[:return_to] = request.path
          redirect '/logon'
        end
        
        file = File.join( settings.public_folder, 'index.html' )
        File.open file
      end
      
      error do
        file = File.join( settings.public_folder, '500.html' )
        File.open file
      end
      
      not_found do
        file = File.join( settings.public_folder, '404.html' )
        File.open file
      end
    end
  end
end
