//     Ribs.js 0.0.1
//     (c) 2012-2014 Jordan Yaker, Inventive Minds, Llc.
//     Ribs may be freely distributed under the MIT license.
//     For all details and documentation:
//     http://inventive-minds.com
(function () {
  // Initial Setup
  // -------------
  // Save a reference to the global object (`window` in the browser, `global`
  // on the server).
  var root = this;

  // Save the previous value of the `Ribs` variable, so that it can be
  // restored later on, if `noConflict` is used.
  var previousRibs = root.Ribs;

  // The top-level namespace. All public Ribs classes and modules will
  // be attached to this. Exported for both CommonJS and the browser.
  var Ribs;
  if (typeof exports !== 'undefined') {
      Ribs = exports;
  } else {
      Ribs = root.Ribs = {};
  }

  // Current version of the library. Keep in sync with `package.json`.
  Ribs.VERSION = '0.0.1';

  // Require Underscore, if we're on the server, and it's not already present.
  var _ = root._;
  if (!_ && (typeof require !== 'undefined')) _ = require('underscore');

  // Require Backbone, if we're on the server, and it's not already present.
  var Backbone = root.Backbone;
  if (!Backbone && (typeof require !== 'undefined')) Backbone = require('backbone');
  
  // For Ribs' purposes, jQuery, Zepto, or Ender owns the `$` variable.
  var $ = root.jQuery || root.Zepto || root.ender;

  // Set the JavaScript library that will be used for DOM manipulation and
  // Ajax calls (a.k.a. the `$` variable). By default Ribs will use: jQuery,
  // Zepto, or Ender; but the `setDomLibrary()` method lets you inject an
  // alternate JavaScript library (or a mock library for testing your views
  // outside of a browser).
  Ribs.setDomLibrary = function(lib) {
      $ = lib;
  };

  // Runs Backbone.js in *noConflict* mode, returning the `Ribs` variable
  // to its previous owner. Returns a reference to this Ribs object.
  Ribs.noConflict = function() {
      root.Backbone = previousBackbone;
      return this;
  };
 
  // Ribs.View
  // -------------
  // Extends the Backbone.View module with extra consideration for a
  // hierarchical control/eventing mechanism.
  Ribs.View = Backbone.View.extend({
    constructor: function(options) {
      if (options) {
        this.parent = options.parent;
        this.views = (options.views || {});
      }
      
      Ribs.View.__super__.constructor.apply(this, arguments);
    },
    
    // **render** is still the core function that your view should override, in order
    // to populate its element (`this.el`), with the appropriate HTML. However, the main
    // addition to the render method is the additional rendering of all child views at 
    // the same time.  This means that the method should be invoked by all methods 
    // overriding it.
    render: function () {
      views = _.reject(this.views, function (view) {
        return view == null;
      });

      _.each(views, function (view) {
        view.render(arguments);
      });
      
      return this;
    },
    
    // **remove** is also still very similar to the Backbone.View.remove method.  The 
    // additions provided by Ribs.View are mainly for better handling of events and dealing
    // with a hierarchical structure of child views.
    remove: function() {
      // Add the handling of checks for removal approval.
      var event = { cancel: false };
      this._beforeRemoval(event);
      
      // Check if the removal of the view has been canceled.
      if (event.cancel) return false;
      
      // Invoke the actual removal of the view.
      this._invokeRemoval();
      
      // Handle the post-removal actions and the clean-up for the view.
      this._afterRemoval();
      
      return this;
    },
    
    // Performs the event cleanup and notifications after the view has been
    // officially removed from the DOM.
    _afterRemoval: function () {
      this.trigger('removed', this);
      
      views = _.reject(this.views, function (view) {
        return view == null;
      });
      
      _.each(views, function (view) {
        view._afterRemoval();
      });
      
      Ribs.View.__super__.off.apply(this);
      Ribs.View.__super__.undelegateEvents.apply(this);
    },
    
    // Performs a check of the removal of view before actually removing the view.
    // In order to interrupt the view, simply subscribe to the **removing** event
    // and set the cancel property of the event argument to true.
    _beforeRemoval: function (event) {
      this.trigger('removing', this, event); 
      
      if (!event.cancel) {
        event.cancel = _.any(this.views, function (view) {
          var e = _.clone(event); 
          
          view._beforeRemoval(e);
          
          return e.cancel;
        });
      }
    },
    
    // Handles the actual removal of the view and all child view elements.
    _invokeRemoval: function () {
      views = _.reject(this.views, function (view) {
        return view == null;
      });
      
      _.each(views, function (view) {
        view._invokeRemoval();
      });

      Ribs.View.__super__.remove.apply(this);
    }
  });
}).call(this);
