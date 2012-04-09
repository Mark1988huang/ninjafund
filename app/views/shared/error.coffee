window.NF.Views.Shared ||= {}

class window.NF.Views.Shared.Error extends Backbone.View
  className: 'nNote nFailure hideit'
    
  template: JST['shared/error']
  
  events:
    'click' : '_on_click'
  
  render: =>
    $(@el).html @template(@model.toJSON())
    return @
    
  #
  # Event Handlers
  #
  _on_click: =>
    $(@el).fadeTo 200, 0.00, () =>
      $(@el).slideUp 300, () =>
        @remove(); return @
      return @
    return @