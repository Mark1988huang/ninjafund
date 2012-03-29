class window.NF.Views.Master extends Ribs.View
  tagName: 'body'
  
  template: JST['master']
  
  render: =>
    # Render the content of the master template.
    $(@el).html @template()
    
    # Render the content of the children in the proper locations.
    @.$('#topNav').replaceWith @views['top_nav'].render().el
    @.$('#header').replaceWith @views['header'].render().el
    @.$('#footer').replaceWith @views['footer'].render().el
    return @