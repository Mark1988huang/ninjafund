window.NF.Views.Users ||= {}

class window.NF.Views.Users.List extends Ribs.View
  id: 'content'
  
  className: 'content'
    
  template: JST['users/list']
    
  render: =>
    $(@el).html @template()
    
    # Render the jQuery widgets for the view.
    table = @$('table').dataTable({
      'bJQueryUI': true
      'bFilter' : false
      'bProcessing': false
      'sPaginationType' : 'full_numbers'
      'sDom' : '<""f>t<"F"lp>'
    }).fnProcessingIndicator()
    
    super (arguments)
