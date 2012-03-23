window.NF.Views.Main ||= {}

class window.NF.Views.Main.Home extends Backbone.View
	template: JST['main/home']

	initialize: (options) ->
	  @model.bind("change:name", @_on_name_changed)
	  return @
	
	render: =>
    $(@el).html @template(@model.toJSON())
    return @
    
  #
  # Event Handlers
  #  
  _on_name_changed: (model, name) =>
    $(@el).find('#topNav .welcome span').text(name)
    return @