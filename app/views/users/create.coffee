window.NF.Views.Users ||= {}

class window.NF.Views.Users.Create extends Ribs.View
  id: 'content'
  
  className: 'content'
    
  template: JST['users/create']

  events:
    'click #cancel' : '_on_click_cancel'

  render: =>
    $(@el).html @template()
    
    # TODO: Initialize the validation indicators.
    
    return @
    
  #
  # Event Handlers
  #
  _on_click_cancel: =>
    window.history.back()
    return @
