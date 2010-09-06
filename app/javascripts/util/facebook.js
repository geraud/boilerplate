/*extern App, FB*/

App.namespace('App.util.facebook', {
  appID: null,

  permissions : 'email, publish_stream, user_about_me, user_hometown, read_friendlists',

  initialize: function () {
  },

  configure: function (configuration) {
    this.appId = configuration.appId;
    this.permissions = configuration.permissions || this.permissions;
    FB.init({ appId: this.appId, status: true, cookie: true, xfbml: true });
  },

  login: function (create_url, from_url) {
    // FB.Event.subscribe('auth.login', function(response) {
    //  // Reload the application in the logged-in state
    //   window.top.location = 'http://apps.facebook.com/your_app/';
    // });

    var process_response = function (response) {
      if (!response || !response.perms || response.perms.indexOf('email') == -1) {
        window.location = '/'; //params.signupPath;
      } else {
        this.createSession(create_url, from_url);
      }
    }.bind(this);
    FB.login(process_response, { perms: this.permissions });
  },

  createSession: function (create_url) {
    var request = new Ajax.Request(create_url, { method: 'create' });
  }

});

/* Asynchronous way to do it:

 window.fbAsyncInit = function() {
    var create_session_url = facebook_sessions_url";
    FB.init({ appId : facebook_app_id , status: true, cookie: true, xfbml: true});
    FB.Event.subscribe('auth.sessionChange', function(response) {
      if (response.session) {
        var request =  new Ajax.Request(create_session_url, { method: 'create' });
        // A user has logged in, and a new cookie has been saved
        window.location = '/';
      } else {
        // The user has logged out, and the cookie has been cleared
      }
    });
  };
  (function() {
    var e = document.createElement('script');
    e.async = true;
    e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
    document.getElementById('fb-root').appendChild(e);
  }());
*/
