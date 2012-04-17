window.NF.Models.Users ||= {}

class window.NF.Models.Users.Detail extends Backbone.Model
  parse: (resp, xhr) ->
    return resp.user if resp.user
    resp
