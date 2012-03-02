/* DO NOT MODIFY. This file was compiled Fri, 02 Mar 2012 21:25:33 GMT from
 * /home/jordanyaker/Documents/Projects/ninjafund/app/models/security/logon.coffee
 */

(function() {
  var _base,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  (_base = NF.Models).Security || (_base.Security = {});

  NF.Models.Security.LogonModel = (function(_super) {

    __extends(LogonModel, _super);

    function LogonModel() {
      LogonModel.__super__.constructor.apply(this, arguments);
    }

    LogonModel.prototype.defaults = {
      username: '',
      password: ''
    };

    return LogonModel;

  })(Backbone.Model);

}).call(this);
