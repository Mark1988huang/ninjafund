NF.Views.Security ||= {}

class NF.Views.Security.LogonView extends Backbone.View
  template: JST['security/logon']

  id: 'container'

  initialize: ->
    @render()

  destroy: () ->
    @el.empty()
    return false

  render: ->
    @el.html(@template())
    return this

  events:
    'click a.button' : 'destroy'
