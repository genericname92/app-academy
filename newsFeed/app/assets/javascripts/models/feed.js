NewsReader.Models.Feed = Backbone.Model.extend({
  urlRoot: "/api/feeds",

  parse: function (payload) {
    if (payload.latest_entries) {
      this.latest_entries().set(payload.latest_entries);
      delete payload.latest_entries;
    }
    return payload;
  },

  latest_entries: function () {
    if (!this._latest_entries) {
      this._latest_entries = new NewsReader.Collections.Entries({ feed: this });
    }

    return this._latest_entries;
  }
});
