window.NF.Views.Users ||= {}

class window.NF.Views.Users.List extends Ribs.View
  id: 'content'
  
  className: 'content'
    
  template: JST['users/list']
    
  render: =>
    $(@el).html @template()
    super (arguments)
