NewsReader.Views.FeedShowView = Backbone.View.extend({
  template: JST['feeds/show_view'],

  render: function () {
    var view = this.template({ entry: this.model });
    this.$el.html(view);

    return this;
  }
});
