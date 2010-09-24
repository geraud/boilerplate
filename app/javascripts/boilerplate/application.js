(function (window, document, undefined) {
  var _App = window.App;

  var App = {
    window : window,
    document : document,

    namespace: function (namespace, contents) {
      // Add an object to a particular node in the namespace tree
      namespace = App.findOrCreateNamespace(namespace); // Ensure node exists
      for (var property_name in contents) {
        var property_value = contents[property_name];
        // If the property is a function, bind it to the current node in the namespace tree
        if (typeof(property_value) == 'function') {
          namespace[property_name] = function () {
            property_value.apply(namespace, arguments)
          };
        }
        else {
          namespace[property_name] = contents[property_name];
        }
      }
    },

    findOrCreateNamespace: function (namespace) {
      // Find a node in the appropriate namespace tree. If it doesn't exist, initialize
      // it to an empty object and return it.
      var path = namespace.split('.');
      var current_node = window; // All roots are in the global namespace
      for (var i = 0; i < path.length; i++) {
        current_node[path[i]] = current_node[path[i]] || {}; // Ensure current node exists
        current_node = current_node[path[i]]; // Move down the tree
      }
      return current_node;
    }

  };
})(this, this.document);
