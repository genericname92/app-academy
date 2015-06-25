NewsReader.Collections.Entries = Backbone.Collection.extend({
  model: NewsReader.Models.Entry,
  comparator: "created_at",

  url: function () {
    return this.feed.url() + '/entries';
  }

});
