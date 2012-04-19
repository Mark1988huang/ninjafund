class window.NF.Routers.Users extends Backbone.Router
  routes:
    'users' : '_list'
    'users/create' : '_create'
    
  #
  # Route Handlers
  #
  _list: =>
    return false if window.NF.Master.views['content'] && !window.NF.Master.views['content'].remove()
    
    view = window.NF.Master.views['content'] = new window.NF.Views.Users.List
      parent: window.NF.Master
      collection: new window.NF.Collections.Users.Details 
      
    window.NF.Master.$('#content').html view.render().el
    
    window.NF.Master.$('li:not(.users) a.active, li.users a:not(.active)').toggleClass 'active'
    @
    
  _create: =>
    return false if window.NF.Master.views['content'] && !window.NF.Master.views['content'].remove()
    
    view = window.NF.Master.views['content'] = new window.NF.Views.Users.Create
      model: new window.NF.Models.Users.Detail
      collection: new window.NF.Collections.Users.Details

    window.NF.Master.$('#content').html view.render().el
    
    window.NF.Master.$('li:not(.users) a.active, li.users a:not(.active)').toggleClass 'active'
    @
      
(window.NF.Application ||= {})['users'] = new window.NF.Routers.Users      
