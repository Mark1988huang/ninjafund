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
  _on_change: =>
    @model.set {
      'email' : @$('#email').val()
      'name' : @$('#name').val()
      'password' : @$('#password').val()
    } , { 
      silent: true 
    }
    return @
  
  _on_cancel: =>
    window.history.back()
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
    
    options = 
      wait: true
      success: (model, response) =>
        Backbone.history.navigate '/users', { trigger: true }
        return @
      error: (model, xhr) =>
        # Convert the response to a JSON object.
        response = JSON.parse xhr.responseText
        
        # Set the default error message for the creation of the user.
        error_message = 'An unexpected error has occurred while creating a new user.'
        # Map the error returned from the server.
        switch response.code
          when 10001
            error_message = 'We\'re sorry, but an e-mail address is required when creating a user.'
          when 10002
            error_message = 'Oh no! It looks like the supplied e-mail address is already in use.'
          when 10003
            error_message = 'Oh no! It looks like the supplied e-mail address is too long.  Please shorten it to less than 128 characters and try again.'
          when 10004
            error_message = 'We\'re sorry, but a name is required when creating a user.'
          when 10005
            error_message = 'Oh no! It looks like the supplied name is too long.  Please shorten it to less than 128 characters and try again.'
          when 10006
            error_message = 'We\'re sorry, but a password is required when creating a user.'

        # Add the error view to the collection of child views
        view = @views['error'] = new window.NF.Views.Shared.Error
          model: new window.NF.Models.Shared.Error { message : error_message }
        $(@el).find('.title').after view.render().el      
        return @
    
    @model.save null, options
      
    return false
