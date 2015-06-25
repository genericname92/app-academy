Journal.Views.PostItem = Backbone.View.extend({
  template: JST['posts/item'],
  tagName: 'li',
  events: {
    "click button": "deletePost",
    "click link.post-edit": "editPost"
  },
  render: function() {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },

  editPost: function(){
    Backbone.history.navigate("");
  },

  deletePost: function() {
    this.model.destroy();
    this.remove();
  }
});
