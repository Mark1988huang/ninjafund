window.NF.Views.Main ||= {}

class window.NF.Views.Main.Dashboard extends Backbone.View
  id: 'content'
  
  attributes:
    'class' : 'content'

  template: JST['main/dashboard']

  #
  # View Overrides
  #
  initialize: (options) ->
    @children = {}; @parent = options.parent
    return @
    
  render: =>
    $(@el).html template()
    return @    
