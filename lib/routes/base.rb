module NinjaFund
  module Routes
    class Base < Sinatra::Base
      configure do
        # set the path to the public folder for static files
        set :public_folder, File.expand_path( '../../public', File.dirname(__FILE__) )
        
        # enable the use of the event-machine gem when processing requests
        enable :threaded
        
        # enable sessions for the application
        enable :sessions
      end
      
      #
      # METHODS
      # 
      def warden
        env['warden']
      end
    end
  end
end
