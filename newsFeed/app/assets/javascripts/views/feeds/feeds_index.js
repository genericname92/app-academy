NewsReader.Views.FeedsIndex = Backbone.View.extend({
  template: JST['feeds/index'],

  initialize: function () {
    this.listenTo(this.collection, 'reset remove', this.render);
  },

  events: {
    "click button.keel": "keelFeed"
  },

  render: function () {
    this.$el.html(this.template());

    var ul = this.$el.find('.index');
    this.collection.models.forEach(function(feed){
      var item = new NewsReader.Views.FeedIndexItem({ model: feed });
      ul.append(item.render().$el);
    });

    var newFeed = new NewsReader.Models.Feed();
    var newForm = new NewsReader.Views.FeedForm({ model: newFeed, collection: this.collection });
    this.$el.append(newForm.render().$el);

    return this;
  },

});
