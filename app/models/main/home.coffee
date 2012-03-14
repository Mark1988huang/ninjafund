window.NF.Models.Main ||= {}

class window.NF.Models.Main.Home extends Backbone.Model
  url: '/current/user'

  defaults:
    'user' : ''