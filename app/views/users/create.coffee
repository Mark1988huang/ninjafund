window.NF.Views.Users ||= {}

class window.NF.Views.Users.Create extends Ribs.View
  className: 'content'
    
  template: JST['users/create']

  events:
    'click #cancel' : '_on_cancel'
    'keyup input': '_on_keyup'
    'click #submit' : '_on_submit'
    'submit form'   : '_on_submit'
    'change input'  : '_on_change'

  initialize: ->
    @model.collection = @collection
    return @

  remove: =>
    $('.formError').remove()
    super()

  render: =>
    $(@el).html @template()
    
    # Initialize the validation indicators.
    @$('#create-user').validationEngine()   
    return @
    
  #
  # Event Handlers
  #
  _on_change: (e) =>
    value = e.currentTarget.value.trim(),
    unless value == ''
      @model.set e.currentTarget.name, value,
        silent: true
    return @
  
  _on_cancel: =>
    Backbone.history.navigate '/users', { trigger: true }
    return @

  _on_keyup: (e) =>
    switch e.keyCode
      when 27
        @_on_cancel()
      when 13
        @_on_submit()
    return @

  _on_submit: =>
    @views['error'].remove() if @views['error']
    
    @model.save null,
      wait: true
      success: (model, response) =>
        Backbone.history.navigate '/users', { trigger: true }
        return @
      error: (model, xhr) =>
        # Convert the response to a JSON object.
        resp = JSON.parse xhr.responseText
      
        # Set the default error message for the creation of the user.
        error_message = window.Errors.get resp.code.toString()
        # Add the error view to the collection of child views
        $.jGrowl '<p>' + error_message + '</p>', { theme: 'nNote nFailure' }
        return @
    
    return false
