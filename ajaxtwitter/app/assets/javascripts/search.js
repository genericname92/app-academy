$.UsersSearch = function (el) {
  this.$el = $(el);
  this.current_user = this.$el.data("current-user-id");
  this.$query = $('.search-bar').attr("value");
  this.$listedUsers = $('.listed-users');
  this.handleInput();
};

$.UsersSearch.prototype.handleInput = function() {
  var that = this;
  this.$el.on("keyup", function() {
    that.$listedUsers.empty();
    $.ajax({
      type: 'GET',
      url: "/users/search",
      data: { query: $('.search-bar').val() },
     success: that.renderResults.bind(that),
      dataType: 'json'
    });
  });
};

$.UsersSearch.prototype.renderResults = function(response) {
  for (var i = 0; i < response.length; i++){
    var newLine = $('<li>');
    var responseFollow = response[i].followed;
    var followState = (responseFollow ? "are_following" : "not_following");
    newLine.append($('<a>').attr("href", "/users/" + response[i].id).text(response[i].username));
    var templateString = $('#button_template').html();
    var templateFn = _.template(templateString);
    var content = templateFn( { id: response[i].id, follow_state:  followState});
    newLine.append(content);
    this.$listedUsers.append(newLine);
  }
  $('.follow-toggle').followToggle();
};


$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};

$(function () {
  $("div.users-search").usersSearch();
});
