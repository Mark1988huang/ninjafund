window.NF.Views.Dashboard ||= {}

class window.NF.Views.Dashboard.Main extends Ribs.View
  id: 'content'
  
  attributes:
    'class' : 'content'

  template: JST['dashboard/main']

  #
  # View Overrides
  #
  render: =>
    $(@el).html @template()
    return @
    