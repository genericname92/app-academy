Journal.Views.PostForm = Backbone.View.extend({
  template: JST["posts/post_form"],
  events: {
    "submit form.formSubmit": "submitForm"
  },
  initialize: function(){
    this.listenTo(this.model, "sync remove add reset", this.render);
  },
  render: function(){
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },

  submitForm: function(event) {
    event.preventDefault();
    var that = this;
    var form = $(event.currentTarget).serializeJSON().post;
    this.model.save(form, {
        wait: true,
        success: function(model) {
          Backbone.history.navigate("#posts/" + model.get("id"), {trigger: true});
        },
        error: function(model, response) {
          $('.errors').append(response.responseText);
      }
    });
  }
});
