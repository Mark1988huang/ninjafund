module NinjaFund
  # set the path of the public directory relative to the current file
  set :public_directory, File.dirname(__FILE__) + '/../public'

  # load all of the application routes.
  require_relative 'routes/init'
end
