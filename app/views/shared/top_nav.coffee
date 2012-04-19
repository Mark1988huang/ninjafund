window.NF.Views.Shared ||={}

class window.NF.Views.Shared.TopNav extends Ribs.View
  id: 'topNav'

  template: JST['shared/top_nav']
  
  events:
    'click #logout' : '_on_logout'
  
  initialize: (options) ->
    @model.on 'change', @_on_model_change, @
    @
    
  render: =>
    $(@el).html @template(@model.toJSON())
    @
    
  #
  # Event Handlers
  #
  _on_logout: =>
    # TODO: Check the user wishes to terminate the application.
    
    # Terminate the current session and transfer the user to the logon page.
    Backbone.sync 'read', null, {
      url: '/session/logout',
      success: ->
        window.location = '/logon'
    }
    false
  
  _on_model_change: (model) =>
    changes = model.changedAttributes()
  
    # Change the name of the current user if it has been updated.
    @$('.name').text(changes.name) if changes.name
    @
