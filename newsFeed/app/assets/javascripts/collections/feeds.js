NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: "/api/feeds",
  model: NewsReader.Models.Feed,

  entries: function(){
    if(!this._entries){
      this._entries = new NewsReader.Collections.Entries({feed: this});
      this._entries.fetch();
    }
    return this._entries;
  },

  getOrFetch: function(id){
    var model = this.get(id);
    var feeds = this;
    if (model) {
      model.fetch();
    } else {
      model = new NewsReader.Models.Feed({id: id});
      model.fetch({
        success: function () {
            feeds.add(model);
        }
      });
    }
    return model;
  }
});
