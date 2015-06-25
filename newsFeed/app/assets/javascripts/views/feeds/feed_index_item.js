NewsReader.Views.FeedIndexItem = Backbone.View.extend({
  template: JST["feeds/index_item"],
  events: {
    "click button.kill": "killItem"
  },
  initialize: function(){
    this.listenTo(this.model, "sync", this.render);
  },

  render: function(){
    this.$el.html(this.template({ feed: this.model }));
    return this;
  },
  killItem: function(){
    this.model.destroy();
    this.remove();
  }
});
