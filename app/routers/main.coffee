class window.NF.Routers.Main extends Backbone.Router
	routes:
		"": "_dashboard"	
		
	#
	# Route Handlers
	#	
	_dashboard: =>
	  # check if the current content needs view can be removed.
	  return false if window.NF.Master.views['content'] && !window.NF.Master.views['content'].remove()
	  
	  # Initialize and render the new main content section.
	  view = window.NF.Master.views['content'] = new window.NF.Views.Dashboard.Main { 
	    parent: window.NF.Master 
	  }
	  window.NF.Master.$('#content').replaceWith view.render().el
	  
	  # Set the indicators for the dashboard being active.
	  window.NF.Master.$('li.dash a, li a.active').toggleClass 'active'
	  return @

# Initialize the router and add it to the application
(window.NF.Application ||= {})['main'] = new window.NF.Routers.Main
