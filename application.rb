require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, :development)

require_relative 'lib/ninjafund'

# configure the settings for Barista
Barista.setup_defaults
Barista.root = './app'
Barista.output_root = './public/resources/scripts'

# initialize the use of Barista
use Barista::Filter if Barista.add_filter?
use Barista::Server::Proxy


