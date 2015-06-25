NewsReader.Views.FeedsShow = Backbone.View.extend({
  template: JST['feeds/show'],
  events: {
    "click .refresh": "refresh"
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  refresh: function () {
    this.model.fetch();
  },

  render: function () {
    this.$el.html(this.template({ feed: this.model }));
    var ul = this.$el.find('.entries');

    this.model.latest_entries().forEach(function (entry) {
      var view = new NewsReader.Views.FeedShowView({ model: entry });
      ul.append(view.render().$el);
    });

    return this;
  }
});
