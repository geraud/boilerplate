App.namespace('App.util.actions', {
  initialize: function () {
  },

  linkActions: function () {
    $$('a[data-action]').each(function (element) {
        if (!Object.isUndefined(element.onlclick))
          return;
        var action_name = element.readAttribute('data-action');
        if (Object.isUndefined(action_name)) {
          console.error('could not find data action with name ' + action_name);
          return;
        }
        element.onclick = App.actions[action_name];
    });
  }
});
