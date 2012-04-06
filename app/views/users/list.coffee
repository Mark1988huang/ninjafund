window.NF.Views.Users ||= {}

class window.NF.Views.Users.List extends Ribs.View
  id: 'content'
  
  className: 'content'
    
  template: JST['users/list']
  
  initialize: ->
    @collection.on 'add', @_on_collection_add
    @collection.on 'reset', @_on_collection_reset
    return @
    
  render: =>
    $(@el).html @template()
    
    # Render the jQuery widgets for the view.
    @$('table').dataTable({
      'bJQueryUI' : true
      'bProcessing' : true
      'sPaginationType' : 'full_numbers'
      'sDom' : 'T<"fix">rt<"F"lp>'
      "aoColumns": [
        { 
          "mDataProp": "id"
          "fnRender": ( o, val ) ->
            _.string.pad o.aData.id, 8, '0'
        },
        { 
          "mDataProp": "name" 
        },
        { 
          "mDataProp": "email" 
        }
      ]
    }).fnProcessingIndicator()
    @$("select, input:checkbox, input:radio").uniform()
    
    # invoke the population of the collection
    @collection.fetch()
    
    super (arguments)
    
  #
  # Event Handlers
  #
  _on_collection_add: (model) =>
    @$('table').dataTable().fnAddData model.toJSON()
    return @

  _on_collection_reset: (models) =>
    data = models.map (m) -> m.toJSON()
    
    table = @$('table').dataTable()
    table.fnProcessingIndicator false; table.fnAddData data
    return @
