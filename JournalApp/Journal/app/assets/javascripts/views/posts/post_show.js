Journal.Views.PostShow = Backbone.View.extend({
  template: JST['posts/show'],

  initialize: function(){
    this.listenTo(this.model, "sync remove add reset", this.render);
  },

  events: {
    "click button": "deletePost",
    "dblclick h1.title": "goEdit",
    "dblclick div.body": "goEdit",
    "blur h1.title": "submitForm",
  },

  deletePost: function() {
    this.model.destroy();
    this.remove();
    Backbone.history.navigate("");
  },

  goEdit: function(event){
    var el = event.currentTarget;
    var inputBox = $('<textarea>').attr('name', el.className);
    inputBox.text(el.textContent);
    this.$el.find('.' + el.className).html(inputBox);
  },

  submitForm: function(event) {
    event.preventDefault();
    var textarea = $(event.currentTarget).find("textarea");
    var key = textarea.attr('name');
    var value = textarea.val();
    var that = this;
    var form = {  key : value };
    this.model.save(form, {
        wait: true,
        success: function(model) {
          that.render();
        },
        error: function(model, response) {
          $('.errors').append(response.responseText);
      }
    });
  },

  render: function() {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },
});
