module NinjaFund
  class Application < Base
    get '/' do
      if warden.unauthenticated?
        session[:return_to] = request.path
        redirect '/logon'
      end
      
      file = File.join( settings.public_folder, 'index.html' )
      File.open file
    end
    
    get '/logon' do
      redirect '/' if warden.authenticated?
      
      file = File.join( settings.public_folder, 'logon.html' )
      File.open file
    end
    
    post '/logon' do
      # TODO: Handle the authentication of the user using the supplied details.
    end
  end
end
