$.TweetCompose = function (el) {
  this.$el = $(el);
  this.submit();
  this.formEnabled = true;
};

$.TweetCompose.prototype.submit = function (){
  var that = this;
  this.$el.on("submit", function(event) {
    event.preventDefault();
    if (!that.formEnabled) {
      return;
    }
    that.formEnabled = false;
    var json = $('.tweet').serializeJSON;
    $.ajax({
      type: 'POST',
      url: '/tweets',
      data: json,
      success: that.handleSuccess.bind(that),
      dataType: 'json'
    });
});
};

$.TweetCompose.prototype.handleSuccess = function() {
  this.clearInput();
  this.formEnabled = true;
};

$.TweetCompose.prototype.clearInput = function() {
  $('.tweet-content').text = '';
};

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};

$(function () {
  $(".tweet-compose").tweetCompose();
});
