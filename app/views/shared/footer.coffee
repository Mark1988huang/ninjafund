window.NF.Views.Shared ||={}

class window.NF.Views.Shared.Footer extends Ribs.View
  template: JST['shared/footer']
  
  id: 'footer'
  
  render: =>
    $(@el).html @template()
    @
