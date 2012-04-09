class window.NF.Routers.Users extends Backbone.Router
  routes:
    'users' : '_list'
    'users/create' : '_create'
    
  #
  # Route Handlers
  #
  _list: =>
    # check if the current content view can be removed.
    return false if window.NF.Master.views['content'] && !window.NF.Master.views['content'].remove()
    
    # Initialize the new users content for the view. 
    view = window.NF.Master.views['content'] = new window.NF.Views.Users.List
      parent: window.NF.Master
      collection: new window.NF.Collections.Users.Details 
      
    window.NF.Master.$('#content').replaceWith view.render().el
    
    # Set the indicators for the dashboard being active.
    window.NF.Master.$('li.users a, li a.active').toggleClass 'active'
    return @
    
  _create: =>
    return false if window.NF.Master.views['content'] && !window.NF.Master.views['content'].remove()
    
    view = window.NF.Master.views['content'] = new window.NF.Views.Users.Create
      model: new window.NF.Models.Users.Detail
      collection: new window.NF.Collections.Users.Details

    window.NF.Master.$('#content').replaceWith view.render().el
    
    window.NF.Master.$('li.users a, li a.active').toggleClass 'active'
    return @
      
# Initialize the router and add it to the application
(window.NF.Application ||= {})['users'] = new window.NF.Routers.Users      
