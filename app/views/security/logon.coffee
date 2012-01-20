NF.Views.Security ||= {}

class NF.Views.Security.LogonView extends Backbone.View
  template: JST['security/logon']

  el: '#container'

  initialize: ->
    @model = new NF.Models.Security.LogonModel
    @render()

  destroy: =>
    $(@el).empty()
    return false

  render: =>
    $(@el).html(@template())
    return this

  events:
    'click a.button' : 'destroy'
    'change input' : 'onChange'
    'submit form' : 'onSubmit'
  
  serialize: =>
    return {
      username: $(@el).find('#username').val()
      password: $(@el).find('#password').val()
    }

  onChange: (e) =>
    field = $(e.currentTarget); data = {}
    data[field.attr('id')] = field.val()
    @model.set data

  onSubmit: =>
    #TODO: Submit the content of the serialized string to the server.
   
    return false
