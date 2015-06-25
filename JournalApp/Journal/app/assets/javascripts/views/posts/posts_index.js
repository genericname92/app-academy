Journal.Views.PostsIndex = Backbone.View.extend({
  tagName: 'ul',
  className: 'posts',
  template: JST['posts/index'],

  initialize: function(){
    this.listenTo(this.collection, "sync remove add reset destroy", this.render);
  },
  render: function() {
    var content = this.template({collection: this.collection});
    this.$el.html(content);
    var that = this;
    this.collection.forEach(function(post) {
      var view = new Journal.Views.PostItem({model: post});
      that.$el.append(view.render().$el);
    });
    return this;
  }

});
