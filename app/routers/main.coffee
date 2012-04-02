class window.NF.Routers.Main extends Backbone.Router
	routes:
		"": "_dashboard"	
		
	#
	# Route Handlers
	#	
	_dashboard: =>
	  # TODO: Check if there is a current content view.
	  
	  # Initialize and render the new main content section.
	  view = window.NF.Master.views['content'] = new window.NF.Views.Dashboard.Main
	  window.NF.Master.$('#content').replaceWith view.render().el
	  
	  # Ensure that the TO-TOP indicator is displayed if required.
	  $().UItoTop({ easingType: 'easeOutQuart' });
	  
	  # Set the indicators for the dashboard being active.
	  window.NF.Master.$('li.dash a').addClass 'active'
	  return @

# Initialize the router and add it to the application
(window.NF.Application ||= {})['main'] = new window.NF.Routers.Main