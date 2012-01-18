/* DO NOT MODIFY. This file was compiled Wed, 18 Jan 2012 22:54:44 GMT from
 * /home/jordanyaker/Documents/My Projects/ninjafund/app/views/security/logon.coffee
 */

(function() {
  var _base,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  (_base = NF.Views).Security || (_base.Security = {});

  NF.Views.Security.LogonView = (function(_super) {

    __extends(LogonView, _super);

    function LogonView() {
      LogonView.__super__.constructor.apply(this, arguments);
    }

    LogonView.prototype.template = JST['security/logon'];

    LogonView.prototype.id = 'container';

    LogonView.prototype.initialize = function() {
      return this.render();
    };

    LogonView.prototype.destroy = function() {
      this.el.empty();
      return false;
    };

    LogonView.prototype.render = function() {
      this.el.html(this.template());
      return this;
    };

    LogonView.prototype.events = {
      'click a.button': 'destroy'
    };

    return LogonView;

  })(Backbone.View);

}).call(this);
