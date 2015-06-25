NewsReader.Routers.Feeds = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.feeds = new NewsReader.Collections.Feeds();
    this.feeds.fetch({ reset: true });
  },

  routes: {
    '': "feedIndex",
    'feeds/:id': "feedShow"
  },
  _swapView: function(newView){
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  },

  feedIndex: function () {
    var view = new NewsReader.Views.FeedsIndex({ collection: this.feeds });
    this._swapView(view);
  },

  feedShow: function(id) {
    var view = new NewsReader.Views.FeedsShow({model: this.feeds.getOrFetch(id)});
    this._swapView(view);
  }
});
