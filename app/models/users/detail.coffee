window.NF.Models.Users ||= {}

class window.NF.Models.Users.Detail extends Backbone.Model
  parse: (resp, xhr) ->
    return resp.user if resp.user
    resp
  
  validate: (attr) ->
    if !attr.name || _.isEmpty attr.name
      return 'We\'re sorry, but a name is required when creating a new user.'
    if attr.name.length > 128
      return 'Oh no! It looks like the supplied name is too long.  Please shorten it to less than 128 characters and try again.'
    if !attr.email || _.isEmpty attr.email
      return 'We\'re sorry, but an e-mail address is required when creating a new user.'
    if attr.email.length > 128
      return 'Oh no! It looks like the supplied e-mail address is too long.  Please shorten it to less than 128 characters and try again.'
    if !attr.password || _.isEmpty attr.password
      return 'We\'re sorry, but a password is required when creating a new user.'
    if attr.password < 8
      return 'Oh no! It looks like the supplied password is too short.  When picking a password, please make it 8 or more characters.'
