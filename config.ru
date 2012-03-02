require 'rubygems'
require 'bundler/setup'

# configure the application through the use of the Rack::Builder class
application = Rack::Builder.app do
  # load all required packages for the default and current environments
  Bundler.require(:default, ENV['RACK_ENV'])

  # load the application files
  require './lib/ninjafund'

  # configure any environment dependent settings
  case ENV['RACK_ENV']
    when 'development'
      # hack the static variable to work around a Jammit limitation
      ::RAILS_ENV = 'development' 
      
      # configure the Jammit settings and modules
      use Jammit::Middleware
      Jammit.load_configuration './config/assets.yml'  
      
      # force Jammit to reload on every request
      Jammit.reload!

      # configure the Barista settings and modules
      use Barista::Filter
      Barista.root = './app'
      Barista.output_root = './public/backbone'
      
      # setup the DataMapper configuration
      DataMapper.setup(:default, ENV['DATABASE_URL'] || 'mysql://localhost/ninjafund.oltp')
	  when 'production'
	    # force the use of SSL for the application
	    use Rack::SSL
	end

  # enable sessions for the application
  use Rack::Session::Cookie, :secret => '732c1db7478b81d72465c55cc6940f46'
  
  # configure warden's settings
  use Warden::Manager do |config|
    config.default_strategies :password
  end
  
  # set the strategies for use by Warden
  Warden::Strategies.add :password, NinjaFund::Security::PasswordStrategy
  
  # setup the serialization of identity parameters in and out of the session
  Warden::Manager.serialize_into_session { |user| user.id }
  Warden::Manager.serialize_from_session { |id| NinjaFund::Model::User.get(id) }
  
	# load the Sinatra application modules using the cascaded configuration
  run Rack::Cascade.new [ 
    NinjaFund::Routes::Application,
    NinjaFund::Routes::Errors
  ]
end

#run the configured application
run application


