window.NF.Views.Shared ||={}

class window.NF.Views.Shared.Header extends Ribs.View
  template: JST['shared/header']
  
  id: 'header'
  
  className: 'wrapper'
  
  render: =>
    $(@el).html @template()
    return @