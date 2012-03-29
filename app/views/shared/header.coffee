window.NF.Views.Shared ||={}

class window.NF.Views.Shared.Header extends Backbone.View
  template: JST['shared/header']
  
  id: 'header'
  
  className: 'wrapper'
  
  render: =>
    $(@el).html @template()
    return @