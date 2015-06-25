NewsReader.Views.FeedForm = Backbone.View.extend({
  template: JST['feeds/feed_form'],
  events: {
    'submit form': 'createFeed'
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    this.$el.html(this.template({ feed: this.model }));

    return this;
  },

  createFeed: function (event) {
    event.preventDefault();

    var attrs = $(event.target).serializeJSON();
    var success = function () {
      this.collection.add(this.model);
      Backbone.history.navigate('#/feeds/' + this.model.id, { trigger: true });
    }.bind(this);

    var errors = function (model, response) {
      $('errors').empty();
      response.responseJSON.forEach(function (el) {
        var $li = $('<li>');
        $li.text(el);
        $('.errors').append($li);
      }.bind(this));
    };

    this.model.save(attrs, {
      wait: true,
      success: success,
      errors: errors.bind(this)
    });
  }
});
