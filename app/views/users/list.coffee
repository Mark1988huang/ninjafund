window.NF.Views.Users ||= {}

class window.NF.Views.Users.List extends Ribs.View
  className: 'content'
    
  template: JST['users/list']
  
  events:
    'click .imgBtn' : '_on_row_remove'
  
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
      "aoColumns": [{ 
          "mDataProp": "id"
          "fnRender": ( o, val ) ->
            _.string.pad o.aData.id, 8, '0'
        }, { 
          "mDataProp": "name" 
        }, { 
          "mDataProp": "email" 
        }, {
          'bSearchable' : false
          'bSortable' : false
          'fnRender' : (o, val) ->
            '<img src="/images/icons/dark/close.png" alt="" class="imgBtn" />'
        }
      ]
    }).fnProcessingIndicator()
    @$("select, input:checkbox, input:radio").uniform()
    
    # invoke the population of the collection
    @collection.fetch()
    
    super arguments
    
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
    
  _on_row_remove: (e) =>
    target = $(e.currentTarget); row = target.closest('tr')[0]
    table = @$('table').dataTable(); id = new Number(table.fnGetData row, 0)
    model = @collection.get(id)
    
    if model
      model.destroy {
        success: ->
          table.fnDeleteRow row
      }
    return @
