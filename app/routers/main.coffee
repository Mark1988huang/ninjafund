class window.NF.Routers.Main extends Backbone.Router
	routes:
		"": "_dashboard"	
		
	#
	# Route Handlers
	#	
	_dashboard: =>
	  return false if window.NF.Master.views['content'] && !window.NF.Master.views['content'].remove()
	  
	  view = window.NF.Master.views['content'] = new window.NF.Views.Dashboard.Main { 
	    parent: window.NF.Master 
	  }
	  window.NF.Master.$('#content').html view.render().el
	  
	  window.NF.Master.$('li:not(.dash) a.active, li.dash a:not(.active)').toggleClass 'active'
	  return @

(window.NF.Application ||= {})['main'] = new window.NF.Routers.Main
