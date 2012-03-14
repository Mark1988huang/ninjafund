module NinjaFund
  module Routes
    class Base < Sinatra::Base
      register Jammit
      
      # handle the configuration of all Sinatra-related parameters
      configure do
        # hack the static variable to work around a Jammit limitation
        ::RAILS_ENV = 'development' 
        # load the Jammit settings and configurations
        Jammit.load_configuration './config/assets.yml' 
        
        # set the path to the public folder for static files
        set :root, File.expand_path( '../..', File.dirname(__FILE__) )
               
        # enable the use of the event-machine gem when processing requests
        enable :threaded
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
