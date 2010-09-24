/*extern App, FB*/

App.namespace('App.util.facebook', {
  appID: null,
  permissions : 'email, publish_stream, user_about_me, user_hometown, read_friendlists',

  configure: function (configuration) {
    this.appId = configuration.appId;
    this.permissions = configuration.permissions || this.permissions;
  },

  initialize: function () {
    var fb_root = App.document.creatElement('div'),
        script = App.document.createElement('script');

    // Setup the fb_root div
    fb_root.id = 'fb_root';
    App.document.getElementsByTagName('body').appendChild(fb_root);

    // Set up the script tag
    script.async = true;
    script.src = App.document.location.protocol + '//connect.facebook.net/en_US/all.js';
    fb_root.appendChild(script);
  },

  asynchronousInitialize: function () {
    var create_session_url = "<%= facebook_sessions_url -%>";
    FB.init({ appId: this.appId, status: true, cookie: true, xfbml: true });
    FB.Event.subscribe('auth.sessionChange', this._fb_handle_session_change);
  },

  _fb_handle_session_change: function (response) {
    if (response.session) {
      // var request =  new Ajax.Request(create_session_url, { method: 'create' });
      // A user has logged in, and a new cookie has been saved
      // window.location = '/';
    }
    else {
      // The user has logged out, and the cookie has been cleared
    }
  },
});
