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
		# Initialize the viewport for the application
		unless window.NF.ViewPort
		  #TODO: Handle the initialization of home view when the viewport is defined.
			m = new window.NF.Models.Main.Home; m.fetch({
			  success: (model) ->
          window.NF.ViewPort = new window.NF.Views.Main.Home { model : model }
          $('body').hide().html(window.NF.ViewPort.render().el).fadeIn('slow')			    
			})
	
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