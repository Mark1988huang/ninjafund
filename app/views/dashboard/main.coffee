window.NF.Views.Dashboard ||= {}

class window.NF.Views.Dashboard.Main extends Ribs.View
  id: 'content'
  
  className: 'content'

  template: JST['dashboard/main']

  #
  # View Overrides
  #
  render: =>
    $(@el).html @template()
    
    # render the jQuery widgets for the dashboard view.
    $().UItoTop { easingType: 'easeOutQuart' }
    
    # invoke the base rendering of the view
    super arguments  