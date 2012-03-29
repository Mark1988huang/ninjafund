class window.NF.Routers.Main extends Backbone.Router
	routes:
		"": "_home"
		"logout" : "_logout"	
		
	events:
	  'route' : '_on_route'
	
	initialize: ->
	  this.on 'route', @_on_route
	  return @	
		
	#
	# Route Handlers
	#	
	_home: () =>
		# TODO: Initialize the dashboard for the application
	  return @
		
	_logout: () =>
		# TODO: Check for any active items in child view items and act accordingly
		window.location = '/logout'
		return @	
		
	#
	# Event Handlers
	# 	
  _on_route: =>
    alert 'route!'
    return @

# Initialize the router and add it to the application
(window.NF.Application ||= {})['main'] = new window.NF.Routers.Main