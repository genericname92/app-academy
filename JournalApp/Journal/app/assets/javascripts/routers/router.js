Journal.Routers.Posts = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.posts = new Journal.Collections.Posts();
    this.$sidebarEl = options.$sidebarEl;
    this.SideBar();
  },

  routes: {
    "": "root",
    "posts/:id/edit": "PostEdit",
    "posts/new": "PostNew",
    "posts/:id": "PostShow"

  },
  _swapView: function (newView) {
  this._currentView && this._currentView.remove();
  this._currentView = newView;
  if (newView) {
    this.$rootEl.html(newView.render().$el);
  } else {
    this.$rootEl.html("");
  }
},

root: function() {
  this._swapView(null);
},

PostShow: function (id, model, options) {
  var post = this.posts.getOrFetch(id);
  var showView = new Journal.Views.PostShow({model: post});
  this._swapView(showView);
},

PostEdit: function(id, model, options) {
  var post = this.posts.getOrFetch(id);
  var editView = new Journal.Views.PostForm({model: post});
  this._swapView(editView);
},

// PostsIndex: function(model, options){
//   this.posts.fetch({"reset": true});
//   var indexView = new Journal.Views.PostsIndex({collection: this.posts});
//   this._swapView(indexView);
// },
SideBar: function(model){
  this.posts.fetch({"reset": true});
  var indexView = new Journal.Views.PostsIndex({collection: this.posts});
  this.$sidebarEl.html(indexView.render().$el);
},

PostNew: function(){
  var post = new Journal.Models.Post();
  var newPostView = new Journal.Views.PostForm({model: post, collection: this.posts});
  this._swapView(newPostView);
}


});
