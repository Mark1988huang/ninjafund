class window.NF.Routers.Main extends Backbone.Router
	routes:
		"": "_dashboard"
		"logout" : "_logout"	

	#
	# Route Handlers
	#	
	_dashboard: =>
	  # Activate the button for the view's link.
	  window.NF.Master.$('#menu .dash a').addClass 'active'
		
		# Initialize the dashboard for the application.
		# window.NF.Master.views['content'] = new window.NF.Views.Main.Desktop()
	  return @
		
	_logout: =>
		# TODO: Check for any active items in child view items and act accordingly
		window.location = '/logout'
		return @	

# Initialize the router and add it to the application
(window.NF.Application ||= {})['main'] = new window.NF.Routers.Main
