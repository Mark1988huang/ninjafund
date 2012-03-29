window.NF.Views.Shared ||={}

class window.NF.Views.Shared.TopNav extends Ribs.View
  template: JST['shared/top_nav']
  
  id: 'topNav'

  initialize: (options) ->
    @model.on 'change', @_on_model_change, @
    return @
    
  render: =>
    $(@el).html @template(@model.toJSON())
    return @
    
  #
  # Event Handlers
  #
  _on_model_change: (model) =>
    changes = model.changedAttributes()
  
    # Change the name of the current user if it has been updated.
    @.$('.name').text(changes.name) if changes.name
  
    return @