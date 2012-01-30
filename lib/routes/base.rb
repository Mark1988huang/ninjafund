module NinjaFund
  class Base < Sinatra::Base
    # set the path to the public folder for static files
    set :public_folder, File.dirname(__FILE__) + '/../../public'
    
    # enable the use of the event-machine gem when processing requests
    enable :threaded
    
    # ----------------------------------
    # Methods
    # ----------------------------------
    def warden
      env['warden']
    end
  end
end
