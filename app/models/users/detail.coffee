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
    if !attr.email.match /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i
      return 'Oh no! It looks like the supplied e-mail address is invalid.  Please correct it to the form of \'name@company.com\' and try again.'
    if !attr.password || _.isEmpty attr.password
      return 'We\'re sorry, but a password is required when creating a new user.'
    if attr.password.length < 8
      return 'Oh no! It looks like the supplied password is too short.  When picking a password, please make it 8 or more characters.'
