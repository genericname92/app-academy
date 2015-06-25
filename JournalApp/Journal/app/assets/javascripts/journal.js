window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // Journal.collection = new Journal.Collections.Posts();
    // Journal.collection.fetch();
    new Journal.Routers.Posts({
      $rootEl: $('.main'),
      $sidebarEl: $('.sidebar')
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Journal.initialize();
});
