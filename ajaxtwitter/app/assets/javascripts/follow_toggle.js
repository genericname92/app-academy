$.FollowToggle = function (el) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id");
  this.followState = this.$el.data("initial-follow-state");
  this.render();
  this.handleClick();
  this.disabled = false;
};

$.FollowToggle.prototype.render = function () {
  var text = (this.followState === "are_following") ? "Unfollow!" : "Follow!";
  this.$el.text(text);
};

$.FollowToggle.prototype.handleClick = function (){
  event.preventDefault();
  var that = this;
  this.$el.on("click", function () {
    if (that.disabled) {

    } else if (that.followState === 'not_following') {
      that.disabled = true;
      $.ajax({
        type: 'POST',
        url: "/users/"+that.userId+"/follow",
        success: function() {
          that.followState = 'are_following';
          that.render();
          that.disabled = false;
        },
        dataType: 'json'
      });
    } else {
      that.disabled = true;
      $.ajax({
        type: 'DELETE',
        url: "/users/"+that.userId+"/follow",
        success: function() {
          that.followState = 'not_following';
          that.render();
          that.disabled = false;
        },
        dataType: 'json'
      });
    }
  });
};

$.fn.followToggle = function () {
  return this.each(function () {
    new $.FollowToggle(this);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
