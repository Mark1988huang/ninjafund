window.NF.Collections.Users ||= {}

class window.NF.Collections.Users.Details extends Backbone.Collection
  url: '/api/v1/users'
  
  model: window.NF.Models.Users.Detail
  
  parse: (response) ->
    return response.users
