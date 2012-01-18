module NinjaFund
  class Base < Sinatra::Base
    # register external modules for utilization by the program
    register Jammit if :development
    register Barista::Integration::Sinatra if :development

    # handle the configuration of the settings for the application
    configure do
      # set the path of the public directory relative to the current file
      set :public_folder, File.dirname(__FILE__) + '/../../public'
      
      # ensure that the static files are served from the public directory
      enable :static

      # setup the server to be multi-threaded
      enable :threaded
    end

    # handle the configuration of the development environment options.
    configure :development do
      # this is needed to work around a Jammit limitation
      ::RAILS_ENV = 'development' 
      Jammit.load_configuration File.dirname(__FILE__) + '/../../config/assets.yml'

      # force Jammit to reload on every request.
      Jammit.reload!

      # handle the configuration of Barista
      Barista.configure do |c|
        # set the root path for the coffeescript files
        c.root = File.dirname(__FILE__) + '/../../app'

        # set the output directory for all of the compiled script files.
        c.output_root = settings.public_folder + '/backbone'
      end
    end 
  end
end
